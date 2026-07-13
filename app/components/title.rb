# frozen_string_literal: true

# Heading group for focused pages (sign-in, confirmations). Owns the
# title/subtitle type scale so these pages line up everywhere.
class Components::Title < Components::Base
  def initialize(title: nil, subtitle: nil)
    @title = title
    @subtitle = subtitle
  end

  def view_template(&)
    hgroup(class: "space-y-1") do
      title { @title } if @title
      subtitle { @subtitle } if @subtitle
      yield if block_given?
    end
  end

  def title(&) = h2(class: "font-bold text-2xl md:text-4xl", &)
  def subtitle(&) = h3(class: "font-semibold text-lg md:text-2xl opacity-60", &)
end
