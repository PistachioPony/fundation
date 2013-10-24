class AddFundingColumn < ActiveRecord::Migration
  def change
    add_column :companies, :funding, :integer
  end
end
