# Handles generating hierarchies of containers and items for the application.
class ApplicationFactory
  include ActiveModel::Model
  attr_accessor :account, :user

  validates :account, presence: true
  validates :user, presence: true

  protected
    def container(name, **attrs, &block)
      generate Container, name: name, **attrs, &block
    end

    def item(name, **attrs, &block)
      generate Item, name: name, **attrs, &block
    end

    def generate(klass, **attrs, &block)
      klass.new(account: account, user: user, **attrs, &block)
    end
end
