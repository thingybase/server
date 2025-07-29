class Components::TitleCard < Components::Card
  def initialize
    super
    @subtitles = []
  end

  def title(&content)
    @title = content
  end

  def subtitle(&content)
    @subtitles << content
  end

  def around_template(&block)
    super do
      render(&block)
    end
  end

  def view_template(&)
    vanish(&)

    h1(id: "card-id", class: [
      "font-bold",
      title_size_classes,
      title_color_classes
    ], &@title)

    @subtitles.each do |subtitle|
      h2(class: "text-red-500", &subtitle)
    end

    yield
  end

  def title_size_classes = "text-2xl"
  def title_color_classes = "text-blue-500"
end
