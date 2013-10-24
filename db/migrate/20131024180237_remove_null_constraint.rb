class RemoveNullConstraint < ActiveRecord::Migration
  def change
    change_column :companies, :name, :string, null: true
  end
end
