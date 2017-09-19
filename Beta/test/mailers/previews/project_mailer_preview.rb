# Preview all emails at http://localhost:3000/rails/mailers/project_mailer
class ProjectMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/project_mailer/new_project_users

  def create_project
  	project = Project.last
  	user = User.last
  	ProjectMailer.create_project(user, project)
  end

  def user_invited
  	project=Project.last
  	user=User.first
  	ProjectMailer.user_invited(user, project)
  end

end
