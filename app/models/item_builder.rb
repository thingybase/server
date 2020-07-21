# A light weight DSL for building out trees of items and containers. Without
# it you'll be building out a very cumbersome tree with a lot of verbose
# setting of user and account.
class ItemBuilder
  attr_reader :scope

  def initialize(user:, account:, scope: Item.none)
    @user = user
    @account = account
    @scope = scope
  end

  # If a block is given, wrap the containers children in an ItemBuilder and pass
  # it into the block.
  def container(name, **kwargs)
    build(**kwargs.merge(name: name, container: true)).tap do |container|
      yield self.class.new(user: @user, account: @account, scope: container.children) if block_given?
    end
  end

  def item(name, **kwargs)
    build **kwargs.merge(name: name, container: false)
  end

  def build(**kwargs)
    @scope.build **kwargs.merge(user: @user, account: @account)
  end
end
