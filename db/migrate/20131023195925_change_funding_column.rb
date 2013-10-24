class ChangeFundingColumn < ActiveRecord::Migration
  def change
    remove_column :companies, :funding
  end
end
