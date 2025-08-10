class Components::Card < Components::Base
  # A text only card
  class Text < self
    def around_template(&)
      super do
        body(&) # Renders the `view_template`
      end
    end
  end

  # For content pages, pass the source page into here and it will
  # make a card that looks decent that links to the page.
  class Page < self
    def initialize(page:, class: "max-w-82 shadow-xl rounded-xl")
      super(class:)
      @url = page.request_path
      @image_url = page.data.fetch("image_url")
      @title = page.data.fetch("title")
      @subtitle = page.data.fetch("subtitle", nil)
    end

    def around_template(&)
      super do
        a(href: @url, &)
      end
    end

    def view_template(&)
      figure(class: "w-full aspect-square") do
        img(src: @image_url, alt: @title, class: "w-full h-full object-cover rounded-t-xl")
      end
      body do
        render Header.new { it.title { @title } }
        p { @subtitle }
        yield if block_given?
        div(class: "justify-end card-actions"){
          div(class: "btn btn-ghost") { "Read more →" }
        }
      end
    end
  end

  def initialize(class: "bg-base-200 md:col-span-2")
    @class = grab(class:)
  end

  def around_template
    super do
      div(class: ["card", @class]) do
        yield # Renders the `view_template`
      end
    end
  end

  def body(class: nil)
    div class: "card-body" do
      yield if block_given?
    end
  end

  class Header < Components::Base
    def view_template(&)
      hgroup(&)
    end

    def title(&)
      h3(class: "card-title", &)
    end

    def subtitle(&)
      h4(class: "font-semibold", &)
    end
  end

  def header(&)
    render Header.new(&)
  end

  def view_template
    yield if block_given?
  end
end
