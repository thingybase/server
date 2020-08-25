class Batch < ApplicationModel
  attr_accessor :action, :user, :account, :scope
  attr_writer :account_id, :items_attributes

  validate :items_selected

  def items
    model_selections(item_scope, selected_items_uids).to_a
  end

  def selected_items_uids
    selected_attributes(@items_attributes)
  end

  def selected_items
    items.select(&:selected)
  end

  def selected_items_models
    selected_items.map(&:model)
  end

  def selected_selections
    selected_items
  end

  def selected_models
    selected_selections.map(&:model)
  end

  def item_scope
    scope.container_then_item
  end

  def account_id
    account&.id
  end

  def save
    valid?
  end

  private
    def items_selected
      errors[:base] << "No items are selected" if selected_selections.empty?
    end

    def model_selections(scope, selected_uids)
      Enumerator.new do |y|
        scope.each do |model|
          selected = selected_uids.include? model.uid.to_s
          y << Selection.new(model: model, selected: selected)
        end
      end
    end

    def selected_attributes(attributes)
      return [] if attributes.nil?
      attributes.map do |_, attrs|
        attrs.fetch("uid") unless attrs.fetch("selected", "0").to_i.zero?
      end.compact
    end
end