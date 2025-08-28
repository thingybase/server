class Components::Forms::Marketing < Components::Form
  class Field < self::Field
    def input(class: "p-6 text-lg", **)
      super(class:, **)
    end
  end
end
