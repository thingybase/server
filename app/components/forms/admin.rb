class Components::Forms::Admin < Components::Form
  class Field < self::Field
    def input(class: "p-1 text-sm", **)
      super(class:, **)
    end
  end
end
