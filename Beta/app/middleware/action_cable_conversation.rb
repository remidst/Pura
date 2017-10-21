class ConversationActionCable < ActionCable::Connection::WebSocket

	def initialize(app, options={})
		@app = app
	end

	def call(env)
		if ::Websocket::Driver.websocket?(env)
			ActionCable.server.call(env)
		else
			@app.call(env)
		end
	end
end