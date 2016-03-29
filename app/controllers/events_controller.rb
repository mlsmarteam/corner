class EventsController < ApplicationController

	respond_to :json


	def create
	end

	def new
	end

	def move
	end

	def resize
	end

	def edit
	end

	def destroy
  end


	def get_events
      start_time     = DateTime.parse(params[:start])
      end_time   	 = DateTime.parse(params[:end])
	    field_id  	 = params[:field]
      field_owner_id = Field.find(field_id).user
      @events = Event.where('
                  ((starttime >= :start_time and endtime <= :end_time) or
                  (starttime >= :start_time and endtime > :end_time and starttime <= :end_time) or
                  (starttime <= :start_time and endtime >= :start_time and endtime <= :end_time) or
                  (starttime <= :start_time and endtime > :end_time)) and (user_id = :field_owner_id) and
      			  (field_id= :field_id)',
                  start_time: start_time, end_time: end_time, field_owner_id: field_owner_id,field_id: field_id)
      events = []
      @events.each do |event|
        events << { id: event.id,
                    title: event.title,
                    description: event.description || '', 
                    start: event.starttime.iso8601,
                    end: event.endtime.iso8601,
                    allDay: event.all_day
                  }
      end
      render json: events.to_json
  end
end
