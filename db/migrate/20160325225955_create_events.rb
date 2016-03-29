class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :starttime
      t.datetime :endtime
      t.text :description
      t.references :user_id, index: true, foreign_key: true
      t.references :field_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
