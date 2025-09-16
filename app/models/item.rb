class Item < ApplicationRecord
  include PgSearch::Model
  include UuidField

  # after_commit on: [:create, :destroy] do
  #   Components::Account::Stats.new(account).broadcast_replace
  # end

  # pg_search_scope :search_by_name,
  #   against: :name,
  #   using: {
  #     trigram: {
  #       threshold: 1.0,
  #       word_similarity: true
  #     },
  #   }

  def self.search_by_name(term)
    where("name ILIKE ?", "%#{term}%")
  end

  has_closure_tree dependent: :destroy

  belongs_to :account, touch: true
  broadcasts_refreshes

  belongs_to :user
  has_one :movement,
    dependent: :destroy,
    foreign_key: :origin_id

  has_one :loanable_item

  validates :name, presence: true
  validates :account, presence: true
  validates :user, presence: true

  validate :convertable_from_container_to_item?
  validate :parent_is_container?
  validate :icon_key_exists?
  validate :not_container_if_loanable?

  before_validation :assign_container_false_if_nil

  before_update :update_counters
  before_create :increment_new_counters
  before_destroy :decrement_old_counters

  DEFAULT_CONTAINER_ICON_KEY = "folder".freeze
  DEFAULT_ITEM_ICON_KEY = "object".freeze

  def children
    ReadonlyAssociationDelegate.new(association: super, readonly: !container)
  end

  def icon
    icon_key || default_icon_key
  end

  def icon=(value)
    self.icon_key = value
  end

  def find_or_create_label(text: name)
    label || create_label!(user: user, account: account, text: text)
  end

  def label
    @label ||= Label.new item: self
  end

  def self.container
    where(container: true)
  end

  def self.item
    where(container: false)
  end

  def self.container_then_item
    order("container DESC, name ASC")
  end

  private
    def update_counters
      if parent_id_changed?
        # Update counts on different parents
        decrement_old_counters
        increment_new_counters
      elsif container_changed?
        # Update counts on the same parent
        parent&.decrement! counter_attribute(container_was)
        parent&.increment! counter_attribute(container)
      end
    end

    def decrement_old_counters
      parent_was&.decrement! counter_attribute(container_was)
    end

    def increment_new_counters
      parent&.increment! counter_attribute(container)
    end

    def counter_attribute(container)
      container ? :containers_count : :items_count
    end

    def parent_was
      self.class.find_by_id parent_id_was
    end

    def default_icon_key
      container ? DEFAULT_CONTAINER_ICON_KEY : DEFAULT_ITEM_ICON_KEY
    end

    def convertable_from_container_to_item?
      if not container? and children.exists?
        errors.add(:container, "must have all items removed before it can be changed to not be a container")
      end
    end

    def not_container_if_loanable?
      if container? and loanable_item
        errors.add(:container, "must be removed from borrowing list")
      end
    end

    def icon_key_exists?
      return if icon_key.blank?
      errors.add(:icon_key, "does not exist") unless Icon.exist? icon_key
    end

    def parent_is_container?
      return if root?
      errors.add(:parent, "must be a container") if not parent.container?
    end

    def assign_container_false_if_nil
      # Nil implies its not a container, but if we store it as a nil in that column
      # we get three different types if we group by `container`, so force a Nil to be
      # False. A database constraint was put into place to make sure this happens.
      self.container = false if container.nil?
    end
end
