require 'pdf-reader'

def extract_text_from_pdf(file_path)
  text = ""

  reader = PDF::Reader.new(file_path)

  reader.pages.each do |page|
    text << page.text
  end

  text
end
