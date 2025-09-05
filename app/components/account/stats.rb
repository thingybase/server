# frozen_string_literal: true

class Components::Account::Stats < Components::Base
  include Phlex::Rails::Helpers::TurboStreamFrom

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

  def after_template
    subscribe
    super
  end

  def subscribe
    turbo_stream_from dom_id if context.any?
  end

  def broadcast_replace(streamable = dom_id, target: dom_id)
    Turbo::StreamsChannel.broadcast_replace_to(streamable, target:, content: call)
  end
end
