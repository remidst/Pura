# Preview all emails at http://localhost:3000/rails/mailers/reporting_mailer
class ReportingMailerPreview < ActionMailer::Preview

  def received_reporting
  	reporting = Reporting.last
    ReportingMailer.received_reporting(reporting)
  end


end
