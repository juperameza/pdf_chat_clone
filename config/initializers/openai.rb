OpenAI.configure do |config|
    config.access_token = RAils.application.credentials[:openai_api_key]
  end
