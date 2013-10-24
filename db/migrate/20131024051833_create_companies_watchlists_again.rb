class CreateCompaniesWatchlistsAgain < ActiveRecord::Migration
  def change
    create_table :companies_watchlists do |t|
      t.belongs_to :company, null: false
      t.belongs_to :watchlist, null: false
    end
  end
end
