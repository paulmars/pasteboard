class CreateSitefiles < ActiveRecord::Migration
  def change
    create_table :sitefiles do |t|
      t.integer :board_id

      t.timestamps
    end
  end
end
