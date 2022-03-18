class FlashMessageComponent < ViewComponent::Base
  def initialize(message:, type:)
    super
    @message = message
    @type = type
    @alert_class = alert_class_name(type)
  end

  def render?
    @message.present?
  end

  private

  def alert_class_name(type)
    case type
    when :alert
      "alert-warning"
    when :notice
      "alert-info"
    else
      ""
    end
  end
end
