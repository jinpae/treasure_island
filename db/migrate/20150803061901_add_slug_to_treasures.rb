class AddSlugToTreasures < ActiveRecord::Migration
  def change
    add_column :treasures, :slug, :string
  end
end
