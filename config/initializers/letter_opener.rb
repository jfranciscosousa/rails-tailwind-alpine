if Rails.env.development?
  LetterOpener.configure do |config|
    config.location = Rails.root.join("tmp/emails")

    config.message_template = :default
  end
end
