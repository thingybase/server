class AddLabelableToLabel < ActiveRecord::Migration[5.2]
  def change
    add_reference :labels, :labelable, polymorphic: true
  end
end
