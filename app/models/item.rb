class Item < ApplicationRecord
  include PgSearch::Model
  include UuidField

  pg_search_scope :search_by_name, against: :name

  has_closure_tree dependent: :destroy

  has_one :label
  belongs_to :account
  belongs_to :user

  validates :name, presence: true
  validates :account, presence: true
  validates :user, presence: true

  validate :valid_chronic_dates
  validate :shelved_at_less_than_end?
  validate :convertable_from_container_to_item?
  validate :parent_is_container?
  validate :icon_key_exists?

  before_save :assign_shelf_life_range

  def valid_chronic_dates
    errors.add :shelved_at, "is an invalid date" if !valid_chronic_date?(@shelved_at)
    errors.add :expires_at, "is an invalid date" if !valid_chronic_date?(@expires_at)
  end

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

  attr_writer :shelved_at
  def shelved_at
    @shelved_at ||= begin
      shelf_life&.begin == -Float::INFINITY ? nil : shelf_life&.begin
    end
  end

  attr_writer :expires_at
  def expires_at
    @expires_at ||= begin
      shelf_life&.end == Float::INFINITY ? nil : shelf_life&.end
    end
  end

  def assign_shelf_life_range
    begin_date = parse_date(@shelved_at)
    end_date = parse_date(@expires_at)
    self.shelf_life = begin_date..end_date
  end

  def self.container
    where(container: true)
  end

  def self.container_then_item
    order("container DESC").order(:name)
  end

  private
    def default_icon_key
      container ? DEFAULT_CONTAINER_ICON_KEY : DEFAULT_ITEM_ICON_KEY
    end

    def shelved_at_less_than_end?
      assign_shelf_life_range
      return if shelf_life.nil?

      if (shelf_life.end && shelf_life.begin) && shelf_life.begin > shelf_life.end
        errors.add(:shelved_at, "must happen before expires at")
      end
    end

    def convertable_from_container_to_item?
      if not container? and children.exists?
        errors.add(:container, "must have all items removed before it can be changed to not be a container")
      end
    end

    def icon_key_exists?
      return if icon_key.blank?
      errors.add(:icon_key, "does not exist") unless SvgIconFile.exist? icon_key
    end

    def parent_is_container?
      return if root?
      errors.add :parent, "must be a container" if not parent.container?
    end

    def valid_chronic_date?(date)
      date.blank? || parse_date(date)
    end

    def parse_date(date)
      case date
      when String
        Chronic.parse(date, context: :past)&.utc
      else
        date
      end
    end

    def today
      Time.now.utc.to_date
    end
end
