class Search
  include ActiveModel::Validations
  attr_accessor :phrase
  validates :phrase, presence: true

  def initialize(phrase: nil, items: Item, containers: Container)
    @item_scope = items
    @container_scope = containers
    @phrase = phrase
  end

  def items
    search_by_name_scope @item_scope
  end

  def containers
    search_by_name_scope @container_scope
  end

  def empty?
    items.empty? and containers.empty?
  end

  private
    def search_by_name_scope(scope)
      phrase.present? ? scope.search_by_name(phrase) : scope.none
    end
end