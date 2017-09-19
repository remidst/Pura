class ProjectMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.project_mailer.new_project.subject
  #

  def create_project(user, project)
  	@user = user
  	@project = project

  	mail to: @user.email, subject: "新しい案件'#{@project.project_name}'が登録されました。" 
  end

  def user_invited(user, project)
    @user = user
    @project = project
    @leader = User.find(@project.leader_id)

    mail to: @user.email, subject: "#{@leader.username}様から'#{@project.project_name}'の案件に招待されました。"
  end

end
