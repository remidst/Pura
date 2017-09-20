# Preview all emails at http://localhost:3000/rails/mailers/project_mailer
class ProjectMailerPreview < ActionMailer::Preview

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

  def goodbye_registered_user
    user = User.first
    project = Project.last
    ProjectMailer.goodbye_registered_user(user, project)
  end

end
