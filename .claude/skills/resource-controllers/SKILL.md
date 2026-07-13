---
name: resource-controllers
description: Create a Thingybase resource controller with Oxidizer, inline Phlex views (Superview), a Superform DataForm, Pundit authorization, and Oxidizer-DSL routes
argument-hint: [resource-name]
allowed-tools: Read, Grep, Glob, Edit, Write, Bash, AskUserQuestion
---

# Resource Controllers with Oxidizer, Superview, and Phlex

Create a controller for `$ARGUMENTS` following this project's pattern: Oxidizer resource controller + Phlex views nested inside the controller file + a Superform `DataForm` + a Pundit policy. One file holds the controller, its action views, and its form.

## The core idea

- **Oxidizer writes the CRUD** — you override hooks (`permitted_params`, `permitted_order_params`, `destroy_redirect_url`), not actions.
- **Views live inside the controller** as nested Phlex classes (`Show`, `Edit`, `Form`, variants). No separate view files, no partials.
- **Every action is authorized** — `ApplicationController` enforces `verify_authorized`/`verify_policy_scoped`, so a policy must exist before the controller works.

`app/controllers/items_controller.rb` is the canonical reference. Read it first.

## Complete example: account-scoped resource

```ruby
class WidgetsController < Oxidizer::ResourcesController
  include AccountLayout
  include ResourceAnalytics
  include Superview::Actions

  def phlex
    super.tap do |view|
      view.account = @account
      view.user = current_user
    end
  end

  class Show < AccountLayout::Component
    attr_writer :widget

    def title = @widget.name
    def subtitle
      Breadcrumb do |it|
        it.crumb { show(@account, :name) }
        it.crumb { show(@widget, :name) }
      end
    end

    def view_template
      DataView @widget do |it|
        it.field(:created_at)
        it.field(:updated_at)
        it.field(:user) { @widget.user.name }
      end
    end

    def action_template
      div(class: "join") do
        LinkButton(edit_widget_path(@widget), class: "join-item") { "Edit" }
      end

      Menu title: "More..." do |it|
        it.item do
          delete(@widget, confirm: "Are you sure?") { "Delete" }
        end
      end
    end
  end

  class Form < DataForm
    def view_template
      TextField :name
      Submit { "Save" }
    end
  end

  class Edit < Show
    def view_template
      render Form.new(@widget)
    end
  end

  protected
    def navigation_key
      "Widgets"
    end

  private
    def destroy_redirect_url
      account_widgets_url(@widget.account)
    end

    def permitted_order_params
      [:name, :created_at, :updated_at]
    end

    def permitted_params
      [:name, :account_id]
    end
end
```

## Key concepts

### View hierarchy
- Account-scoped action views inherit from `AccountLayout::Component`, which renders `PageTitle` from your `title` / `subtitle` / `icon` methods, an action-button row from `action_template`, and your `view_template` inside the account layout.
- Optional methods: `action_template` (button row under the title), `search_template` (renders a `SearchField`).
- Variant views subclass the base view — `ItemsController::Container` and `::Item` both subclass `Show`, and `#show` picks one at render time:

```ruby
def show
  view_class = @item.container? ? Container : Item
  render assign_component_accessors(view_class.new), layout: false
end
```

### Forms
- One `Form < DataForm` per controller, using the field DSL: `TextField`, `SelectField`, `CheckboxField`, `Submit { "Save" }`. `DataForm` owns the DaisyUI styling — never restyle fields inline.
- Collections for selects must be policy-scoped: `helpers.account_policy_scope(::Item.container)` — never a bare `Model.all`.
- Hints: `TextField :expires_at, hint: 'Dates like "next week" work'`.

### Authorization (required, not optional)
- Create a policy in `app/policies/` inheriting from the right base:
  - `BaseAccountMemberPolicy` — any account member may CRUD (most resources)
  - `BaseAccountOwnerPolicy` — only the account owner
  - `BaseLoanableListMemberPolicy` / `BaseUserRequestPolicy` — lending/request flows
- Public exceptions are explicit methods (`ItemPolicy#scan? = true`).
- Without a policy the controller 500s on `verify_authorized` — this is by design.

### Routes (Oxidizer DSL)
Match the existing style in `config/routes.rb` — `nest`, `list`, `create`, `edit`, `show` macros, resources nested under `accounts`:

```ruby
resources :widgets

resources :accounts do
  nest :widgets
end
```

New verbs become nested resources (`create :movement`, `create :copies`), never custom member actions.

### Nested namespaces
Deeper resources get module-nested controllers mirroring the route: `Widgets::BatchesController` in `app/controllers/widgets/batches_controller.rb`.

## Steps

1. **Ask the user** what the resource is, whether it's account-scoped, and who may act on it (member vs owner).
2. **Read references**: `app/controllers/items_controller.rb` (canonical), `app/controllers/application_controller.rb` (security), a sibling policy.
3. **Create the policy** first, inheriting the correct base. Add a policy spec using pundit-matchers (see `spec/policies/`).
4. **Create the controller** with `Show`/`Edit`/`Form` inline.
5. **Add routes** in the existing Oxidizer DSL style.
6. **Write specs** — model spec + policy spec, matching `spec/` layout.
7. **Verify**: `bin/rails routes | grep widget` and `bin/rspec spec/policies/widget_policy_spec.rb`.
