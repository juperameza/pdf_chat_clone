require 'pdf-reader'
require 'rest-client'
require 'json'
require 'openai'

def extract_text_from_pdf(file_path)
  text = ""

  reader = PDF::Reader.new(file_path)

  reader.pages.each do |page|
    text << page.text
  end

  text
end

def send_text_to_chatbot_api(text)
  client = OpenAI::Client.new
  prompt = [
    {
    "role": "system",
    "content": "You know this pdf #{text}}"
    },
    {
    "role": "user",
    "content": "Give me a sumarry about that pdf"
  }]

  response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: prompt,
      temperature: 0.7
    }
  )
  response.dig("choices", 0, "message", "content")

end
