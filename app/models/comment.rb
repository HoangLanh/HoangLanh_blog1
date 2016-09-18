class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  delegate :name, :avatar, to: :user, prefix: true
end
