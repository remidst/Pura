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

  if Rails.env.production?
    font_dir = File.join(Dir.home, ".fonts")
    Dir.mkdir(font_dir) unless Dir.exists?(font_dir)

    Dir.glob(Rails.root.join("vendor", "fonts", "*")).each do |font|
      target = File.join(font_dir, File.basename(font))
      File.symlink(font, target) unless File.exists?(target)
    end
  end

end


