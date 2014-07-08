class AddUserToFiles < ActiveRecord::Migration
  def change
    add_column :sitefiles, :user_id, :integer
    Sitefile.update_all("user_id = 1")
  end
end
