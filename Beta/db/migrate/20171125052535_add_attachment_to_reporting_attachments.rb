class AddAttachmentToReportingAttachments < ActiveRecord::Migration[5.1]
  def change
  	add_column :reporting_attachments, :attachment, :string
  end
end
