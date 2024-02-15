class ApplicationForm < Superform::Rails::Form
  def Select(name, *, **, &)
    render field(name).select(*, **, &)
  end

  def Input(name, *, **, &)
    render field(name).input(*, **, &)
  end

  def Submit(*, **, &)
    button(*, type: "submit", **, &)
  end

  def Label(name, *, **, &)
    render field(name).label(*, **, &)
  end
end
