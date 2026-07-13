# Agent Preferences

Thingybase: organize, track & treasure your stuff. Users create **Accounts**, add hierarchical **Items** (containers nest items via closure_tree), print **QR-code PDF labels**, scan labels to look items up, **move** items between containers, and **loan** items to others via loanable lists. Stripe subscriptions gate features by plan. Rails edge + Ruby 3.4.2 + PostgreSQL, deployed to Heroku.

## Guiding Principles (from README — these override cleverness)
- **Avoid JavaScript** — do everything server-side. PDFs render to PNGs on the server; state lives in Postgres, not the browser. Reach for a Rails/HTTP solution before a JS one.
- **No part is the best part** — radical simplicity. Delete code, don't add abstractions. If a feature can be modeled with an existing mechanism, use it.
- **Keep data structures simple** — plain RESTful resources with standard CRUD actions. Model new behavior as a resource, not a custom action.

## Security: secure by default
- Every action requires an authenticated user AND a Pundit check: `ApplicationController` runs `before_action :authenticate_user`, `after_action :verify_authorized` (except index), and `verify_policy_scoped` (index). Forgetting to authorize raises — this is intentional.
- Opt out explicitly and rarely with `self.skip_security!` (public pages, webhooks, label scans).
- In controllers/views, never query models directly — go through `policy_scope` / the account (`@account.items`, `user.accounts`). `ItemsController::Form` uses `helpers.account_policy_scope(::Item.container)` for this reason.
- Policies inherit from a base matching who may act: `BaseAccountMemberPolicy` (most account resources), `BaseAccountOwnerPolicy`, `BaseLoanableListMemberPolicy`, `BaseUserRequestPolicy`. One policy per model. Public exceptions are explicit methods (e.g. `ItemPolicy#scan?`).
- Feature gating goes through Featureomatic: `current_plan` is the account's Stripe plan or `FreePlan`. Gate features by plan, not by ad-hoc conditionals.
- Auth is custom (no Devise): Google OAuth via OmniAuth + passwordless email sign-in links via `nopassword` 1.0 (rubymonolith). The sign-in page is `SessionsController::New` (`/session/new`); the email flow lives in `EmailAuthenticationsController` (link-based challenge/verification, session-backed — no DB table). New emails route through `SignupsController` via `session[:authentic_email]` to collect a name. Sessions are cookies (`session[:user_id]`) with 30-day rolling expiration and rotation. Don't touch session handling without asking.
- Billing uses `nocheckout` (rubymonolith): `Accounts::PaymentsController` includes `NoCheckout::Stripe::CheckoutSession`; `Webhooks::StripeWebhooksController` subclasses `NoCheckout::Stripe::WebhooksController`. Stripe config is ENV-based (`STRIPE_PRIVATE_KEY` via initializer, `STRIPE_SIGNING_SECRET`, `STRIPE_ACCOUNT_PRICE`).

## Controllers
- Resource controllers subclass `Oxidizer::ResourcesController` — don't hand-write CRUD. Override the hooks instead: `permitted_params`, `permitted_order_params`, `destroy_redirect_url`.
- Account-scoped controllers `include AccountLayout` (sets `@account`, picks the account layout, denies cross-account access) and `include Superview::Actions`.
- **Views are Phlex classes nested inside the controller file** (`Show`, `Edit`, `Form`, plus variants like `ItemsController::Container` vs `::Item`), rendered with `layout: false`. Don't create separate view files for controller actions. `ItemsController` is the canonical shape.
- Action views inherit from `AccountLayout::Component` and define `title`, `subtitle` (usually a `Breadcrumb`), `icon`, `view_template`, and optionally `action_template` (button row) and `search_template`.
- Override `phlex` to hand extra state to views: `super.tap { |view| view.account = @account }`.
- Deeply nest controller namespaces to mirror routes: `Items::BatchesController`, `Accounts::Payments`, `Items::Templates::ContainersController`.
- `ResourceAnalytics` concern tracks create/update/destroy in Ahoy — include it on user-facing resource controllers.

## Routes
- Routes use Oxidizer's DSL macros (`nest`, `list`, `create`, `edit`, `show`) — read `config/routes.rb` before adding routes and follow the existing style.
- Batch operations use the `batch_resources` helper (comma-separated ids → `#{name}/batches` controllers).
- Everything is a resource. New verbs become nested resources (`create :movement`, `create :copies`), never custom member actions.

## Phlex 2.x
- `view_template` is the render method, `around_template(&)` for wrappers.
- No `unsafe_raw` — use `raw(safe("..."))`; mark safe strings with `safe("...")`.
- `plain` for text output, `whitespace` for spaces, `comment` for comments.
- Classes as strings are fine: `class: "btn btn-primary"`; arrays only when dynamic.
- Avoid `it` in Phlex blocks with nested tags — use named block params (existing code uses `do |it|` on component slot APIs like `Menu`/`Breadcrumb`; follow that style there).
- New Phlex files get `# frozen_string_literal: true`.

## Components & Forms
- Shared components live in `app/components/` and inherit from `Components::Base`. Reuse before building: `PageTitle`, `Breadcrumb`, `DataView`, `Menu`, `SearchField`, `EmptyList`, `List::Items`, `Icon`, `Vector`, `Card`, `Stats`, `Tab`.
- Forms are Superform: controller-local `Form < DataForm` classes using the field DSL — `TextField :name`, `SelectField :parent, collection`, `CheckboxField :container`, `Submit { "Save" }`. `DataForm` owns DaisyUI styling; don't restyle fields inline.
- Read `docs/design-system.md` before building new UI.

## Models
- `ApplicationRecord` for persisted models; `ApplicationModel` (ActiveModel, `persisted? => false`) for form/state objects like `InvitationResponse`, `ItemBuilder`, `MovementBuilder`.
- URL params use short UUIDs via the `UuidField` concern + `find_resource` — never expose raw ids on new user-facing resources.
- `Item` is the heart: `has_closure_tree`, `container` boolean, counter caches (`containers_count`/`items_count`) maintained in callbacks, pg_search. Understand it before touching hierarchy logic.
- Models that back live UI use `broadcasts_refreshes` (Turbo page refreshes) — prefer that over Turbo Streams.
- Natural-language dates parse through `chronic` (e.g. `Item#expires_at` accepts "6 months from now").

## Turbo & JS
- Importmap only — no bundler. Turbo Drive + page refreshes for interactivity; `broadcasts_refreshes` on models.
- Avoid Stimulus; the only custom controller is `clipboard_controller.js`. Adding JS needs strong justification per the README principles.
- Never `button_to` for new code — `link_to ... data: { turbo_method: :delete }`.

## Testing (RSpec)
- Model specs (shoulda-matchers), policy specs (pundit-matchers), request specs, component specs, mailer specs — match the existing `spec/` layout. FactoryBot factories live in `spec/factories.rb`.
- Every new policy gets a spec — authorization is where bugs hurt most here.
- Every new controller gets a request spec covering the happy path AND the denial path (anonymous → 401, other account's user → 403). Sign in with the `sign_in(user)` helper (`spec/config/authentication.rb`) — it goes through the real OmniAuth callback.
- Test what we ship, not the framework: exercise real routes, policies, and rendering. Don't write specs that only restate a gem's behavior.
- One assertion per spec; `describe`/`context` to organize; `let()` for data.
- SimpleCov reports coverage to `coverage/` on every run — don't let it drop.
- Run: `bin/rspec` or `bundle exec rspec` (Spring-enabled). Keep the suite fast — it runs in seconds; no sleeps, no external HTTP.

## CI (GitHub Actions, `.github/workflows/ci.yml`)
Every push/PR to `main` must pass three jobs before anything ships:
- **Lint** — `bundle exec rubocop` (rails-omakase style). Existing offenses are grandfathered in `.rubocop_todo.yml`; new/edited code must be clean. Never add to the todo file — fix the offense instead.
- **Security** — `brakeman`, `bundler-audit` (gem CVEs), and `bin/importmap audit` (JS CVEs). If bundler-audit fails, update the vulnerable gem conservatively (`bundle update --conservative <gem>`); never ignore an advisory without asking.
- **Tests** — `zeitwerk:check` + full RSpec suite against Postgres.
Run all three locally before handing work over: `bundle exec rubocop && bundle exec brakeman -q --no-pager && bundle exec rspec`.

## Bug Fixes
- Write a failing spec first that reproduces the bug, run it to confirm it fails, apply the fix, confirm it passes, commit spec + fix together.

## Database Migrations
- Before committing: rollback, edit the migration in place, migrate again — keep migrations atomic per commit. Don't stack fix-up migrations on uncommitted ones.

## Commits
- Stage in logical groups and present for review — NEVER commit directly.
- NEVER co-sign commits (no `Co-authored-by` / attribution to Claude).

## Code Style
- Ruby kwargs shorthand (`super(title:, url:)`), pattern-matching shorthand, `&:method` / `it` in simple blocks.
- Anonymous forwarding: `def foo(*, **, &)` — don't name args unless referenced (see `DataForm`).
- Endless methods for simple accessors (`def title = @item.name`); multi-line for real logic.
- `case` over `is_a?` chains for type checks.
- Multiple related classes in one file is fine (controller + its views + its form); split when they get big.
- No `.rubocop.yml` — match the style of the file you're editing.

## Scope
- Keep work narrowly scoped to what's requested. Don't write docs or extra files unless asked.
- User manually reviews all work closely.

## Dev environment
- `bin/setup` to bootstrap; `docker compose up -d` for Postgres; `bin/dev` runs the server (port 5000) + `tailwindcss:watch`.
- `bin/rails runner` for quick console checks; Blazer lives on the `blazer` subdomain.
- Deploys: Heroku (`git push heroku master`) — never deploy without being asked.
