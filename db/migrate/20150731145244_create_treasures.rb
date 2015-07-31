class CreateTreasures < ActiveRecord::Migration
  def change
    create_table :treasures do |t|
      t.string :name
      t.string :url
      t.text :description
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :treasures, :users
  end
end
