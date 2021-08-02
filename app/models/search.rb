class Search
  include ActiveModel::Validations
  attr_accessor :phrase, :items, :created_at
  validates :phrase, presence: true

  # If people search by UUID, it must be at least 6 characters. This makes it more difficult to try
  # find items by throwing short prefixes in front of it making it slightly more secure.
  PARTIAL_UUID_REGEXP = /^[a-f0-9-]{6,}$/i.freeze

  def initialize(phrase: nil, items: Item)
    @item_scope = items
    @phrase = phrase
    @created_at = Time.now.utc
  end

  def items
    if phrase.blank?
      Item.none
    elsif partial_uuid?
      # There's a super remote chance that somebody is naming their items with
      # hex codes, so we'll also search by text.
      Item.union search_by_uuid_scope(@item_scope),
        search_by_name_scope(@item_scope)
    else
      # Search by title
      search_by_name_scope @item_scope
    end
  end

  def empty?
    items.empty?
  end

  private
    def search_by_name_scope(scope)
      scope.search_by_name phrase
    end

    def search_by_uuid_scope(scope)
      partial_uuid = phrase.downcase
      scope
        .joins(:label)
        .where("labels.uuid::text LIKE :prefix", prefix: "#{partial_uuid}%")
    end

    def partial_uuid?
      PARTIAL_UUID_REGEXP.match? phrase
    end
end
