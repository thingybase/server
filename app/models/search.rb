class Search
  include ActiveModel::Validations
  attr_accessor :phrase, :container
  validates :phrase, presence: true

  def initialize(phrase: nil, items: Item, containers: Container, container: nil)
    @item_scope = items
    @container_scope = containers
    @phrase = phrase
    @container = container
  end

  def items
    search_by_name_scope items_in_container_scope @item_scope
  end

  def containers
    search_by_name_scope containers_in_container_scope @container_scope
  end

  def empty?
    items.empty? and containers.empty?
  end

  private
    def search_by_name_scope(scope)
      return scope.none if phrase.blank?
      scope.search_by_name phrase
    end

    def containers_in_container_scope(scope)
      return scope if container.nil?
      container.descendants
    end

    def items_in_container_scope(scope)
      return scope if container.nil?
      scope.where(container_id: container.self_and_descendant_ids)
    end
end
