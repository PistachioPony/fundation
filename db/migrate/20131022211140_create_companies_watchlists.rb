class CreateCompaniesWatchlists < ActiveRecord::Migration
  def change
    create_table :companies_watchlists do |t|
      t.belongs_to :company, null: false
      t.belongs_to :song, null: false
    end
  end
end
