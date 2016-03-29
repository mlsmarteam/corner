class AddEventSerieIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :event_series_id, :int
  end
end
