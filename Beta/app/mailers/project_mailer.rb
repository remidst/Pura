class ProjectMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.project_mailer.new_project.subject
  #

  def new_project_users(user, project)
  	@user = user
  	@project = project
  	@users = @project.users
  	@leader = User.find(@project.leader_id)

  	mail to: @user.email, subject: "新しい案件'#{@project.project_name}'が登録されました。" 
  end

end
