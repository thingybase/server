# frozen_string_literal: true

class Components::Account::Stats < Components::Base
  def initialize(account)
    @account = account
  end

  def dom_id = super(:account, @account.to_param)

  def view_template
    render Components::Stats.new(id: dom_id) do |stats|
      stats.stat do
        it.title { "Items" }
        it.value { @account.items.count }
      end
      stats.stat do
        it.title { "People" }
        it.value { @account.members.count }
      end
   end
  end
end
