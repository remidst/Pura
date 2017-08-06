class MessagesController < ApplicationController
  def new
  end

  def create
    @project = Project.find(params[:project_id])
    @message = @project.messages.create(message_params)
    redirect_to project_path(@project)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def message_params
    params.require(:message).permit(:content)
  end

end
