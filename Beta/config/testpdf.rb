require "pdfkit"
 
kit = PDFKit.new(<<-HTML)
  <p>Hello Envato!</p>
HTML
 
kit.to_file("hello.pdf")