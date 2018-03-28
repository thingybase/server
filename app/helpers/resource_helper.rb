module ResourceHelper
  def resource_field(name, resource: self.resource, &block)
    block ||= Proc.new{ resource.send(name) }

    render layout: "resource_helper/field",
      locals: { field: name, resource: resource }, &block
  end

  def resource_title
    render partial: "resource_helper/title",
      locals: { title: resource_class.model_name.human.titleize }
  end
end
