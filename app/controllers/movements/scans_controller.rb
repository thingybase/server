module Movements
  class ScansController < NestedWeakResourceController
    def self.parent_resource
      Movement
    end

    def show
      redirect_to @movement
    end
  end
end
