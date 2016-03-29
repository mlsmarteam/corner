class AddAllDayToEvent < ActiveRecord::Migration
  def change
    add_column :events, :all_day, :boolean
  end
end
