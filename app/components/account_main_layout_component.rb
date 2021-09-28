# frozen_string_literal: true

class AccountMainLayoutComponent < ApplicationComponent
  attr_accessor :notice_message

  include PageTitleHelper

  renders_one :header
  renders_one :section
  renders_one :controls
end
