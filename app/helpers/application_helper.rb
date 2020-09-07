require "set"

module ApplicationHelper
  def record_key_for_dom_id(record)
    record.to_param
  end

  def active_link_to(text, path, **opts)
    classes = Set.new(opts.fetch(:class, "").split)
    classes << "menu-item"
    classes << "active" if url_for(path) == request.path
    opts[:class] = classes.to_a.join(" ")
    link_to text, path, **opts
  end

  def render_layout(layout, locals={}, &block)
    render inline: capture(&block), layout: "layouts/#{layout}", locals: locals
  end

  def phone_number(number)
    number.phony_formatted
  end

  def account_policy_scope(klass)
    policy_scope(klass).where(account: @account)
  end

  # Useful for contextualizing variables in HAML
  def with(*object, &block)
    block.call(*object)
  end

  # Wrap whatever form helpers are needed to get the job done.
  def application_form(model, turbolinks_form: application_form_turbolinks_form_enabled?, **kwargs, &block)
    simple_form_for model, turbolinks_form: turbolinks_form, **kwargs, &block
  end

  private
    def application_form_turbolinks_form_enabled?
      not Rails.env.development?
    end
end
