# Preview all emails at http://localhost:3000/rails/mailers/project_mailer
class ProjectMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/project_mailer/new_project
  def new_project_leader
  	project = Project.last
    ProjectMailer.new_project_leader(project)
  end

end
