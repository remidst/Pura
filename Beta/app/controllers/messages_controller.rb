class MessagesController < ApplicationController

  def create
    conversation = Conversation.find(params[:conversation_id])
    message = conversation.messages.create(message_params)
    message.set_user!(current_user)
    project=conversation.project

    redirect_to project_path(project)
  end

  def self.render_with_signed_in_user(user, *args)
    ActionController::Renderer::RACK_KEY_TRANSLATION['warden']||='warden'
    proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap{|i| i.set_user(user, scope: :user)}
    renderer = self.renderer.new('warden' => proxy)
    renderer.render(*args)
  end


  private
  def message_params
    params.require(:message).permit(:content, :user)
  end

end
