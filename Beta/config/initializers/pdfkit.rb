# config/initializers/pdfkit.rb



PDFKit.configure do |config|
  
  config.wkhtmltopdf = 'C:\wkhtmltopdf\bin\wkhtmltopdf.exe'

  config.default_options = {
    :page_size => 'Legal',
    :print_media_type => true,
    :encoding=>"UTF-8",
    :page_size=>"A4",
    :disable_smart_shrinking=> false
  }

end


