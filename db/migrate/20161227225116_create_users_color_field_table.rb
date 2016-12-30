class CreateUsersColorFieldTable < ActiveRecord::Migration[5.0]
  def change
  	create_table :colors do |t|
  	  t.string :h1Color
  	  t.string :bodyColor
  	  t.string :textColor
  	  t.integer :user_id
  	end
  end
end
