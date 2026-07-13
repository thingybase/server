---
name: add-resource
description: Add a complete new resource to Thingybase — migration, model, factory, Pundit policy, Oxidizer controller with inline Phlex views, routes, and specs
argument-hint: [resource-name]
allowed-tools: Read, Grep, Glob, Edit, Write, Bash, AskUserQuestion
---

# Add a new resource

Add a resource called `$ARGUMENTS`, end to end. This is the full checklist; the controller/view pattern itself is documented in the `resource-controllers` skill.

## Steps

1. **Ask the user** to confirm before writing anything:
   - Attributes and types
   - Account-scoped (`belongs_to :account`) or user-scoped?
   - Who may act: any account member, only the owner, or something custom?
   - Which actions it needs (full CRUD or a subset)
   - Whether it should be plan-gated (Featureomatic)

2. **Migration + model**
   - `bin/rails generate migration Create<Names> ...` — include `account:references` and `user:references` for account resources.
   - Model inherits `ApplicationRecord`. If it's a non-persisted form/state object (a "verb" like a confirmation or builder), inherit `ApplicationModel` instead and skip the migration entirely.
   - User-facing resources get short UUIDs in URLs: `include UuidField` and add a `uuid` column (see `app/models/item.rb`).
   - Multi-line associations/validations, one kwarg per line when there are several options.
   - Migration hygiene: if you need to change an uncommitted migration, rollback → edit in place → migrate. Never stack fix-up migrations.

3. **Factory** — add to `spec/factories.rb`, following existing entries (Faker for values).

4. **Policy** — `app/policies/<name>_policy.rb` inheriting from `BaseAccountMemberPolicy` (default), `BaseAccountOwnerPolicy`, or another base. Every policy needs a spec in `spec/policies/` using pundit-matchers. Authorization bugs are the worst bugs in this app — do not skip the spec.

5. **Controller** — follow the `resource-controllers` skill: `Oxidizer::ResourcesController` + `AccountLayout` + `Superview::Actions`, with `Show`/`Edit`/`Form` nested inside the controller file. `app/controllers/items_controller.rb` is the reference.

6. **Routes** — Oxidizer DSL style (`nest`, `create`, `list`), nested under `accounts` when account-scoped. New verbs are nested resources, never custom member actions.

7. **Specs** — model spec (shoulda-matchers for associations/validations) + policy spec. One assertion per spec.

8. **Plan gating (if requested)** — gate through Featureomatic / `current_plan`, following an existing gated feature. Don't write ad-hoc plan conditionals.

## Verification

- `bin/rails db:migrate && bin/rails db:migrate:status` — migration is clean
- `bin/rails routes | grep <name>` — routes exist
- `bin/rails runner "puts <Name>.new.inspect"` — model loads
- `bin/rspec spec/models/<name>_spec.rb spec/policies/<name>_policy_spec.rb` — green
