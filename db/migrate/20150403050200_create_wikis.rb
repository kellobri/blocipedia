class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title
      t.text :body
      t.boolean :privatewiki
      t.references :user, index: true
      t.datetime :last_update_at
      t.string :created_by
      t.timestamps null: false
    end
    add_foreign_key :wikis, :users
  end
end
