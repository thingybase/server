# A model that's not backed by ActiveRecord. Used
# mostly to encapsulate AR business logic into classes
# that transition records between state. For example, when
# a user accepts an invitation, they don't do so directly to
# the `Invitation` AR model; rather its an `InvitationResponse` model.
class ApplicationModel
  include ActiveModel::Model
  extend ActiveModel::Naming

  def initialize(*args, **kwargs)
    super(*args, **kwargs)
    assign_defaults
  end

  # Allows form helpers to properly generate resource URLs for
  # these application models that can't be persisted because they're
  # not in the database.
  def persisted?
    false
  end

  # Called when a model is instanciated.
  def assign_defaults
  end

  # When we're dealing with t/f values, the ||= doesn't work, so we set those
  # defaults up here.
  def assign_default(attr, val)
    self.send("#{attr}=", val)if self.send(attr).nil?
  end

  # Idiomatic transacition blocks for models that manipulate
  # database backed records.
  class << self
    delegate :transaction, to: :'ActiveRecord::Base'

    # When you're hooking up boolean fields to a form in rails, it will return "0" for false
    # and "1" for true, which ActiveModel can't deal with by default. This casts the values
    # into what you'd expect so that working with the data is "truthy" instead of true all the
    # time in the case of a "0" or "1"
    def boolean_attr_accessor(*attrs)
      attr_reader *attrs

      attrs.each do |attr|
        define_method "#{attr}=" do |value|
          instance_variable_set "@#{attr}", ActiveModel::Type::Boolean.new.cast(value)
        end
      end
    end
  end
end
