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

def send_text_to_chatbot_api(text, input)
  route ="#{Rails.root}/db/schema.rb"
  client = OpenAI::Client.new
  prompt = [
    {
    "role": "user",
    "content": "given a database schema like below : \n #{File.read(route)} \n 
    i want to #{input}. Only give me the ruby on rails query, do not explain your work."
  }
]

  response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: prompt,
      temperature: 1
    }
  )
  response.dig("choices", 0, "message", "content")

end
