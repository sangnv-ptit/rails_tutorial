class AddSexAndDobToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :sex, :integer, limit: 1, null: false, default: 0
    add_column :users, :dob, :date
  end
end
