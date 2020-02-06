class Batch < ApplicationModel
  attr_accessor :action, :user, :account, :container
  attr_writer :account_id, :items_attributes, :containers_attributes

  def items
    model_selections(item_scope, selected_items_ids).to_a
  end

  def selected_items_ids
    selected_attributes(@items_attributes)
  end

  def selected_items
    items.select(&:selected)
  end

  def selected_items_models
    selected_items.map(&:model)
  end

  def containers
    model_selections(container_scope, selected_containers_ids).to_a
  end

  def selected_containers_ids
    selected_attributes(@containers_attributes)
  end

  def selected_containers
    containers.select(&:selected)
  end

  def selected_containers_models
    selected_containers.map(&:model)
  end

  def selected_selections
    selected_containers + selected_items
  end

  def selected_models
    selected_selections.map(&:model)
  end

  def container_scope
    container.children
  end

  def item_scope
    container.items
  end

  def account_id
    account&.id
  end

  def save
    true
  end

  private
    def model_selections(scope, selected_ids)
      Enumerator.new do |y|
        scope.each do |model|
          selected = selected_ids.include? model.id.to_s
          y << Selection.new(model: model, selected: selected)
        end
      end
    end

    def selected_attributes(attributes)
      return [] if attributes.nil?
      attributes.map do |_, attrs|
        attrs.fetch("id") unless attrs.fetch("selected", "0").to_i.zero?
      end.compact
    end
end