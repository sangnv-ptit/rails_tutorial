class RemoveNameAndDobAndSexFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :name, :string
    remove_column :users, :sex, :integer
    remove_column :users, :dob, :date
  end
end
