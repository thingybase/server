class Search
  include ActiveModel::Validations
  attr_accessor :phrase, :items, :created_at
  validates :phrase, presence: true

  def initialize(phrase: nil, items: Item)
    @item_scope = items
    @phrase = phrase
    @created_at = Time.now.utc
  end

  def items
    search_by_name_scope @item_scope
  end

  def empty?
    items.empty?
  end

  private
    def search_by_name_scope(scope)
      return scope.none if phrase.blank?
      scope.search_by_name phrase
    end
end
