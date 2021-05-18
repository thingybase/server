module Redcarpet
  module Rails
    DEFAULT_BASE_RENDERER = Redcarpet::Render::HTML
    DEFAULT_OPTIONS = Hash.new

    class << self
      def stack
        @stack ||= Stack.new
      end
    end

    class Stack
      attr_reader :base_renderer, :view_context, :options

      def initialize(base_renderer: DEFAULT_BASE_RENDERER, options: DEFAULT_OPTIONS)
        @base_renderer = base_renderer
        @options = options
      end

      def view_context=(view_context)
        renderer.view_context = view_context
      end

      def delegate(method, to_helper:)
        renderer.define_method method do |*args, **kwargs|
          view_context.send(to_helper, *args, **kwargs)
        end
      end

      def markdown
        Redcarpet::Markdown.new(renderer, options)
      end

      private
        def renderer
          # This makes the view context accessible via the `view_context`
          # method from the Markdown renderer so that helpers can be access.
          @renderer ||= Class.new base_renderer do
            def self.view_context
              @view_context
            end

            def self.view_context=(view_context)
              @view_context = view_context
            end

            def view_context
              self.class.view_context
            end
          end
        end
    end

    class Template
      def call(_, source)
        <<-SOURCE
          Redcarpet::Rails.stack.view_context = self
          Redcarpet::Rails.stack.markdown.render(#{source.inspect})
        SOURCE
      end
    end
  end
end

Redcarpet::Rails.stack.delegate :image, to_helper: :markdown_image

handler = Redcarpet::Rails::Template.new
%i[md markdown].each do |extension|
  ActionView::Template.register_template_handler extension, handler
end
