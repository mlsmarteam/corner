class CambiarNombreColumna < ActiveRecord::Migration
   def self.up
     rename_column :events, :name, :title
   end

   def self.down

   end
end

