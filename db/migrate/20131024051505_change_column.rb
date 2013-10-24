class ChangeColumn < ActiveRecord::Migration
  def change
    drop_table :companies_watchlists
  end
end
