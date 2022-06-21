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

  def render_layout(layout, **kwargs, &block)
    render inline: capture(&block), layout: "layouts/#{layout}", **kwargs
  end

  def phone_number(number)
    number.phony_formatted
  end

  def account_policy_scope(klass)
    policy_scope(klass).where(account: @account)
  end

  # Useful for contextualizing variables in HAML
  def with(*object, &block)
    block.call(*object) if object.all?(&:present?)
  end

  # Wrap whatever form helpers are needed to get the job done.
  def application_form(model, **kwargs, &block)
    simple_form_for model, **kwargs, &block
  end
end
