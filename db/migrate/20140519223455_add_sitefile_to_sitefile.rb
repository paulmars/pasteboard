class AddSitefileToSitefile < ActiveRecord::Migration
  def change
    add_column :sitefiles, :sitefile, :string
  end
end
