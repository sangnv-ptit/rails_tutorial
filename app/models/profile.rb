class Profile < ApplicationRecord
  ATTR = %i(name sex dob)

  enum sex: %i(male female).freeze

  belongs_to :user

  validates :name, presence: true,
    length: {maximum: Settings.name.maximum}
end
