class Item
  # This was implemented this way because the clojure_tree gem
  # needs to be patched to add a `before_add` callback to the `children`
  # association that is capable of checking pre-conditions before a child
  # is added to a node that might not allow for children to be added.
  class ReadonlyAssociationDelegate
    # Raise when trying to append a read-only association.
    AppendError = Class.new(RuntimeError)

    def initialize(association:, readonly:)
      @association = association
      @readonly = readonly
    end

    def <<(*args)
      raise AppendError, "#{@association.inspect} is readonly" if @readonly
      super(*args)
    end

    def method_missing(meth, *args)
      @association.send(meth, *args)
    end

    def respond_to?(meth)
      @association.respond_to?(meth)
    end
  end
end
