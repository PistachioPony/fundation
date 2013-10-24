class ChangeFundingColumnAgain < ActiveRecord::Migration
  def change
    change_column :companies, :funding, :integer, :limit => 8
  end
end
