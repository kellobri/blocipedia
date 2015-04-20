class AddCollaboratorsToWikis < ActiveRecord::Migration
  def change
  	create_table :collaborators do |t|
  		t.string :email
  		t.references :wiki, index: true
  		t.references :user, index: true
  	end
    add_foreign_key :collaborators, :users
    add_foreign_key :collaborators, :wikis
  end
end
