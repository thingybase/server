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

  validate :shelf_life_begin_less_than_end?
  validate :convertable_from_container_to_item?
  validate :parent_is_container?
  validate :icon_key_exists?

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

  def shelf_life_begin
    shelf_life&.begin
  end

  def shelf_life_begin=(date)
    date = parse_date(date)
    return if date.blank?
    self.shelf_life = (date || today)..shelf_life_end
  end

  def shelf_life_end
    shelf_life&.end
  end

  def shelf_life_end=(date)
    date = parse_date(date)
    return if date.blank?
    self.shelf_life = (shelf_life_begin || today)..date
  end

  def self.container
    where(container: true)
  end

  def self.container_then_item
    order("container DESC").order(:name)
  end

  def default_icon_key
    container ? DEFAULT_CONTAINER_ICON_KEY : DEFAULT_ITEM_ICON_KEY
  end

  private

    def shelf_life_begin_less_than_end?
      return if shelf_life.nil?

      if shelf_life_begin > shelf_life_end
        errors.add(:shelf_life_begin, "must be less than shelf life end")
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
