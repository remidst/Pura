# config/initializers/pdfkit.rb



PDFKit.configure do |config|
  if ["development"].include?(Rails.env)
  	config.wkhtmltopdf = 'C:\wkhtmltopdf\bin\wkhtmltopdf.exe'
  else
  end

  config.default_options = {
    :page_size => 'Legal',
    :print_media_type => true,
    :encoding=>"UTF-8",
    :page_size=>"A4",
    :disable_smart_shrinking=> false
  }

end


