class AddKindOfUserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company_user, :boolean
    add_column :users, :person_user, :boolean
  end
end
