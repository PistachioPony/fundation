class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.text :description
      t.string :location
      t.datetime :date_founded
      t.string :logo
      t.text :funding
      t.datetime :last_round
      t.string :industry
      t.belongs_to(:watchlist)
    end
  end
end