class ItemPresenter
  attr_reader :model, :view

  def initialize(model, view)
    @model = model
    @view = view
  end

  def item_status
    unless model.active?
      view.link_to("Dashboard", view.root_path)
    else
      "hello"
    end
  end
end
