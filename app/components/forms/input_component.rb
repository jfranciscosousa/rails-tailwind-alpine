class Forms::InputComponent < ViewComponent::Base
  def initialize(form:, type:, name:, html: {})
    super
    @form = form
    @type = type
    @name = name
    @html = html
  end
end
