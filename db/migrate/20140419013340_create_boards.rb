class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.integer :user_id
      t.string :stub

      t.timestamps
    end
  end
end
