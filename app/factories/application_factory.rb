# Handles generating hierarchies of containers and items for the application.
class ApplicationFactory
  include ActiveModel::Model
  attr_accessor :account, :user

  validates :account, presence: true
  validates :user, presence: true

  protected
    def build_container(**attrs, &block)
      Container.new(account: account, user: user, **attrs, &block)
    end

    def build_item(**attrs, &block)
      Item.new(account: account, user: user, **attrs, &block)
    end
end
