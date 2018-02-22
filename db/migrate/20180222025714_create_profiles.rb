class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.integer :sex, limit: 1, null: false, default: 0
      t.date :dob
      t.references :user, foreign_key: true, index: {unique: true}

      t.timestamps
    end
  end
end
