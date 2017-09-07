# Preview all emails at http://localhost:3000/rails/mailers/project_mailer
class ProjectMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/project_mailer/new_project_users

  def new_project_users
  	project = Project.last
  	user = User.last
  	ProjectMailer.new_project_users(user, project)
  end

end
