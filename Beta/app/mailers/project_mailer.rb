class ProjectMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.project_mailer.new_project.subject
  #
  def new_project_leader(project)
    @project = project
    @users = @project.users
    @leader = User.find(@project.leader_id)

    mail to: @leader.email, subject: "新規案件#{@project.project_name}の登録"
  end
end
