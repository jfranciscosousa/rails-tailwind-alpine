class Forms::FormErrorsComponent < ViewComponent::Base
  def initialize(errors:)
    super
    @errors = errors
  end

  def render?
    @errors&.any?
  end
end
