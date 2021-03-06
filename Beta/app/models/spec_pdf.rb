require "render_anywhere"

class SpecPdf
	include RenderAnywhere

	def initialize(spec)
		@spec = spec
	end

	def to_pdf
		puts "to_pdf method called"
		kit = PDFKit.new(as_html)
		kit.to_file("#{Rails.root}/public/spec.pdf")
		#don't save the files in the public folder
	end

	def filename
		"spec#{spec.id}.pdf"
	end

	private

	attr_reader :spec

	def as_html
		puts "as html method called"
		ActionController::Base.render_to_string(template: "specs/pdf", layout: "spec_pdf", locals: {spec: spec})
	end
end