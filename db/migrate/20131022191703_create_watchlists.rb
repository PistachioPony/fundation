class CreateWatchlists < ActiveRecord::Migration
  def change
    create_table :watchlists do |t|
      t.string :name, null: false
      t.belongs_to :user
    end
  end
end
