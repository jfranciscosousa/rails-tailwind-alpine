require "rails_helper"

RSpec.describe FlashMessageComponent, type: :component do
  it "renders the message" do
    component = described_class.new(type: :alert, message: "Alert")

    expect(
      render_inline(component).to_html,
    ).to include(
      "Alert",
    )
  end
end
