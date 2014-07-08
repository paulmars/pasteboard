class Extension < ActiveRecord::Migration
  def change
    add_column :sitefiles, :extension, :string
  end
end
