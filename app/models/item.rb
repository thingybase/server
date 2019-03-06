class Item < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_name, against: :name

  belongs_to :account
  belongs_to :user
  belongs_to :container, optional: true
  has_one :label, as: :labelable

  validates :name, presence: true
  validates :account, presence: true
  validates :user, presence: true
  validate :shelf_life_begin_less_than_end?

  def shelf_life_begin
    shelf_life&.begin
  end

  def shelf_life_begin=(date)
    return if date.blank?
    self.shelf_life = (parse_date(date) || today)..shelf_life_end
  end

  def shelf_life_end
    shelf_life&.end
  end

  def shelf_life_end=(date)
    return if date.blank?
    self.shelf_life = (shelf_life_begin || today)..parse_date(date)
  end

  private
    def shelf_life_begin_less_than_end?
      return if shelf_life.nil?

      if shelf_life_begin > shelf_life_end
        errors.add(:shelf_life_begin, "must be less than shelf life end")
      end
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
