class AddColorFieldsToUsersTable < ActiveRecord::Migration[5.0]
  def change
  	change_table :users do |t|
  		t.string :h1Color
  		t.string :bodyColor
  		t.string :textColor
  	end
  end
end
