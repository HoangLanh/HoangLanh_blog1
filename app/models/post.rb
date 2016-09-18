class Post < ApplicationRecord
	has_many :comments, dependent: :destroy
	belongs_to :user

	mount_uploader :picture, PictureUploader
	scope :of_users, -> user {where user_id: user.following.ids}
end
