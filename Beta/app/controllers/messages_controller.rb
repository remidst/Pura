class MessagesController < ApplicationController
  def new
  end

  def create
    @project = Project.find(params[:project_id])
    @user = current_user
    @message = @project.messages.create(message_params)
    @message.set_user!(current_user)

    redirect_to project_path(@project), notice: "メッセージが案件メンバーに共有されました。"
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def message_params
    params.require(:message).permit(:content, :user)
  end

end
