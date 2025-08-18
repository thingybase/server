class Views::Mailers::Base < Views::Base
  def around_template
    super do
      render Views::Mailers::Layouts::Base.new do
        yield
      end
    end
  end
end
