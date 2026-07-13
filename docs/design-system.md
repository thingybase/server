# Thingybase Design System

How app pages look and hold together. Read this before building a new page so
it fits the rest of the app. Everything here is derived from the current
component library — when in doubt, open the component and read it.

## Stack

Tailwind CSS 4 + DaisyUI 5, rendered from Phlex components. No JS framework:
Turbo Drive navigation, `broadcasts_refreshes` on models for live updates, and
one Stimulus controller (clipboard). If a design seems to need JavaScript,
redesign it as a server-rendered resource first.

## Page anatomy

Every account-scoped page is a Phlex view inheriting `AccountLayout::Component`,
which lays out (in order):

1. **Title block** — `Components::PageTitle`, fed by the view's
   `title`, `subtitle`, and `icon` methods. Never hand-roll an `h1`.
2. **Action row** — the view's optional `action_template`, a horizontal
   `flex flex-row gap-2` strip of buttons directly under the title.
3. **Content** — the view's `view_template`, inside
   `section.flex.flex-col.gap-4.p-4.md:gap-8.md:p-8`. The layout owns
   spacing; don't add page-level margins inside `view_template`.

The `subtitle` is almost always a breadcrumb trail via the `Breadcrumb`
helper (`Components::Breadcrumb`), walking the item's `ancestors` — see
`ItemsController::Show#subtitle`.

## Buttons and actions

- DaisyUI buttons: `btn btn-primary` for the primary action, `btn-ghost` for
  quiet links. `LinkButton(path, :primary) { "Label" }` is the helper.
- **Group related buttons with `join`**: each button gets `class: "join-item"`
  inside a `div(class: "join")`. This is the standard action-row treatment.
- Overflow actions go in a `Menu title: "More..."` (`Components::Menu`) dropdown.
  Menu items support `enabled:` to conditionally show entries
  (`it.item(enabled: @account.move.present?) { ... }`).
- Destructive actions use `delete(record, confirm: "Are you sure?")` — a
  Turbo-method link, never `button_to`.

## Forms

All forms are Superform `DataForm` subclasses nested in their controller.
`DataForm` owns the field chrome — DaisyUI `form-control`, bold
`label-text` labels, `input input-bordered`, `select select-bordered`,
`checkbox`, and a `btn btn-primary` submit — wrapped in `flex flex-col gap-4`.

Use the DSL and don't restyle inline:

```ruby
TextField :name
TextField :expires_at, hint: 'Dates like "6 months from now" work'
SelectField :parent, [nil, collection], label: "Contained In"
CheckboxField :container
Submit { "Save" }
```

Hints render as muted labels (`label-text opacity-75`) below the field.
Select collections must be policy-scoped (`helpers.account_policy_scope(...)`).

## Displaying records and lists

- **Attribute/value pages** (leaf-item show pages): `DataView record do |it|`
  with `it.field(:created_at)` rows — `DataView` owns the table
  styling. Custom values take a block: `it.field(:user) { record.user.name }`.
- **Collections**: `Components::List::Items` for item lists (with
  `List::ItemCard`/`Card` cards); `EmptyList` for
  the zero state — never an unstyled "no results" string.
- **Search**: `SearchField.new(placeholder: "Search #{name}", url:)`
  rendered from the view's `search_template`.
- **Stats**: `Components::Stats` for numeric summaries; `Tab` for
  tabbed sections; `Card` / `TitleCard` for boxed content.

## Icons and vectors

Item icons are SVG vector assets (`Icon` / `VectorAsset` models) rendered
through `Components::Icon` / `Components::Vector` — note the component
`Components::Icon` wraps the `::Icon` model; qualify the model as `::Icon`
inside component code. Tinting happens server-side via
the `/vectors/hsl-:h,:s,:l/*id` route (dark-mode inversion included) — never
inline a recolored SVG or drop emoji in as icons. Items pick icons by
`icon_key` through the existing icon-picker flow (`edit :icon`).

## Layouts beyond the account app

- `AccountLayout` picks the account layout when `@account` is persisted,
  otherwise the plain `application` layout.
- `focused` layout for single-task flows (login codes, invitations) — no
  account chrome.
- Mailer templates are ERB and stay simple.

## Voice and copy

- Labels are short and verb-first: "Edit", "Select", "Label", "Move", "Copy",
  "+ Add items".
- Confirmations are plain: "Are you sure?".
- Empty states and hints explain in one sentence what the user can do, in
  plain language ("Allow items to be contained within this item. For boxes,
  shelfs and other containers.").

## Rules of thumb

1. Reuse a component from `app/components/` before writing markup.
2. Prefer DaisyUI semantic classes (`btn`, `join`, `menu`, `card`, `badge`)
   over raw Tailwind utility piles; custom styling is a last resort.
3. The layout owns page spacing; views own only their content.
4. If new UI needs JS, stop and model it as a resource instead.
