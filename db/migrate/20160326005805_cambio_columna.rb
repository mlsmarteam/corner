class CambioColumna < ActiveRecord::Migration
    def self.up
     rename_column :events, :user_id_id, :user_id
     rename_column :events, :field_id_id, :field_id
   end

   def self.down

   end

end
