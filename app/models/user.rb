class User < ApplicationRecord
	belongs_to :comments
	enum role: [:guest, :member]
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  default_scope -> { order(created_at: :desc) }

  after_initialize :update_role, if: :new_record?
  
  def is_user? user
    self == user
  end
  def update_role
    self.role = Settings.role.member
  end
end
