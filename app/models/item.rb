class Item < ApplicationRecord
  include PgSearch::Model
  include UuidField

  pg_search_scope :search_by_name, against: :name

  has_closure_tree dependent: :destroy

  belongs_to :account
  belongs_to :user
  has_one :movement,
    dependent: :destroy,
    foreign_key: :origin_id

  validates :name, presence: true
  validates :account, presence: true
  validates :user, presence: true

  validate :convertable_from_container_to_item?
  validate :parent_is_container?
  validate :icon_key_exists?

  before_validation :assign_container_false_to_nil

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

  def self.container_then_item
    order("container DESC, name ASC")
  end

  private
    def default_icon_key
      container ? DEFAULT_CONTAINER_ICON_KEY : DEFAULT_ITEM_ICON_KEY
    end

    def convertable_from_container_to_item?
      if not container? and children.exists?
        errors.add(:container, "must have all items removed before it can be changed to not be a container")
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

    def assign_container_false_to_nil
      # Nil implies its not a container, but if we store it as a nil in that column
      # we get three different types if we group by `container`, so force a Nil to be
      # False. A database constraint was put into place to make sure this happens.
      self.container = false if container.nil?
    end
end
