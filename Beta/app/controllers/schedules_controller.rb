class SchedulesController < ApplicationController

	before_action :set_corporation

	def index
		authorize @corporation, :is_subscribed?
		@schedules = @corporation.schedules.order(created_at: :desc)
	end

	def show
		authorize @corporation, :is_subscribed?
		@schedule = Schedule.find(params[:id])
	end

	def new
		authorize @corporation, :is_subscribed?
		@schedule = Schedule.new
	end

	def create
		authorize @corporation, :is_subscribed?
		@schedule = Schedule.new(schedule_params)
		@schedule.owner_id = current_user.id
		@schedule.corporation_id = @corporation.id

		respond_to do |format|
			if @schedule.save
				format.html {redirect_to @schedule, notice: 'スケジュールが作成されました！'}
			else
				format.html {render action: 'new'}
			end
		end
	end

	def update
		authorize @corporation, :is_subscribed?
	end

	private

	def set_corporation
		@corporation = current_user.corporation
	end

	def schedule_params
		params.require(:schedule).permit(:name, :year, :month)
	end


end