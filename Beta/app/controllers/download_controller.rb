class DownloadController < ApplicationController


	def show
		send_spec_pdf
	end
	
	private
	
	def spec_pdf
	  	spec = Spec.find(params[:id])
	  	SpecPdf.new(spec)
	end
	
	def send_spec_pdf
	  puts "send spec pdf called"
	  send_data	 spec_pdf.to_pdf,
	    filename: spec_pdf.filename,
	    type: "application/pdf",
	    disposition: "inline"
	    # disposition can be switched to "attachment" to force download
	    # caution!!! the to_pdf method saves the file in the public file
	end

end
