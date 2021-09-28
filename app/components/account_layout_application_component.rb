# frozen_string_literal: true

class AccountLayoutApplicationComponent < ApplicationComponent
  attr_accessor :title, :icon, :subtitle

  renders_one :control
  renders_one :section

  def initialize(title:, icon:, subtitle:)
    @icon = icon
    @title = title
    @subtitle = subtitle
  end
end
