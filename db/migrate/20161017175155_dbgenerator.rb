class Dbgenerator < ActiveRecord::Migration
   def change
  	
  	create_table :users do |t|
  		t.string   :email
  		t.string   :password
  		t.string   :fname
  		t.string   :lname
  		t.string   :location
  		t.string   :bio
  		t.string   :birthday
  		t.datetime :joined_at
  	end

  	create_table :posts do |t|
  		t.string   :userName
  		t.string   :text
  		t.string   :title
  		t.datetime :posted_at

  	end

  end
end
