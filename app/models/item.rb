class Item < ApplicationRecord
  include PgSearch::Model

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

  # This was implemented this way because the clojure_tree gem
  # needs to be patched to add a `before_add` callback to the `children`
  # association that is capable of checking pre-conditions before a child
  # is added to a node that might not allow for children to be added.
  class ReadonlyAssociationDelegate
    # Raise when trying to append a read-only association.
    AppendError = Class.new(RuntimeError)

    def initialize(association, readonly)
      @association = association
      @readonly = readonly
    end

    def <<(*args)
      raise AppendError, "#{@association.inspect} is readonly" if @readonly
      super(*args)
    end

    def method_missing(meth, *args)
      @association.send(meth, *args)
    end

    def respond_to?(meth)
      @association.respond_to?(meth)
    end
  end

  def children
    ReadonlyAssociationDelegate.new(super, !container)
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
