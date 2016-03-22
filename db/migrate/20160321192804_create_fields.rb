class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :name
      t.text :description
      t.integer :team_player

      t.timestamps null: false
    end
  end
end
