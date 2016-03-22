class AddOwnerToFields < ActiveRecord::Migration
  def change
    add_reference :fields, :user, index: true, foreign_key: true
  end
end
