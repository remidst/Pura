class ProjectMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.project_mailer.new_project.subject
  #

  def create_project(user, project)
  	@user = user
  	@project = project

  	mail to: @user.email, subject: "#{@project.project_name}様の案件が作成されました。"
  end

  def user_invited(user, project)
    @user = user
    @project = project
    @leader = User.find(@project.leader_id)
    @users = @project.users.where.not("username is null") 

    mail to: @user.email, subject: "#{@leader.username}様から#{@project.project_name}様の案件に招待されました。"
  end

  def goodbye_registered_user(user, project)
    @user=user
    @project=project
    @leader=User.find(@project.leader_id)

    mail to: @user.email, subject: "#{@project.project_name}様の案件へのアクセスが削除されました"
  end

  def goodbye_registered_user_leader_notice(users, project)
    @deleted=users
    @project = project
    @leader = User.find(@project.leader_id)

    mail to: @leader.email, subject: "#{@project.project_name}様の案件からユーザーが削除されました。"
  end

  def old_leader_email(user, project)
    @old_leader=user
    @project = project
    @new_leader = User.find(@project.leader_id)

    mail to: @old_leader.email, subject: "#{@project.project_name}様の案件の担当マネジャーが変わりました。"
  end

  def new_leader_email(user, project)
    @old_leader=user
    @project=project
    @new_leader=User.find(@project.leader_id)

    mail to: @new_leader.email, subject: "#{@project.project_name}様の案件の担当マネジャーの権限が与えられました。"
  end

end
