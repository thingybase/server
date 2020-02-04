require 'active_support/concern'

module Labelable
  extend ActiveSupport::Concern

  included do
    has_one :label, as: :labelable
  end

  def find_or_create_label(text: name)
    label || create_label!(user: user, account: account, text: text)
  end

  class_methods do
  end
end
