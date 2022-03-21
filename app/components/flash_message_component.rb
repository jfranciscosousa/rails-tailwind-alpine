class FlashMessageComponent < ViewComponent::Base
  def initialize(message:, type:)
    super
    @message = message
    @type = type
  end

  def render?
    @message.present?
  end
end
