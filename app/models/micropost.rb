class Micropost < ApplicationRecord
  ATTR = %i(content picture)

  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.max_length}
  validate :picture_size

  scope :most_recent, ->{order created_at: :desc}
  scope :following_microposts,
    ->(following_ids, user_id){where(user_id: following_ids)
      .or(where user_id: user_id)}

  mount_uploader :picture, PictureUploader

  private

  def picture_size
    return unless picture.size > Settings.micropost.picture_size.megabytes
    errors.add :picture, t("micropost.picture_size")
  end
end
