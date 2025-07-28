# config/initializers/console.rb
Rails.application.configure do
  # This block only runs when you're in the Rails console (rails c)
  console do
    # TOPLEVEL_BINDING.eval('self') gets the main object in the console
    # We're extending it with a new module to add custom methods
    TOPLEVEL_BINDING.eval('self').extend(
      Module.new do
        def render(*args, layout: false, **kwargs)
          Rails.logger.silence do
            html = ApplicationController.renderer.render(*args, layout: layout, **kwargs)
            Nokogiri::HTML.fragment(html).to_xhtml(indent: 2)
          end
        end
      end
    )
  end
end
