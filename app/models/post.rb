# frozen_string_literal: true

class Post < ApplicationRecord
  # default_scope { order created_at: :desc } # to make sort posts in desc order
  belongs_to :user
  has_many_attached :images
  has_many :comment, dependent: :destroy
  has_many :likes, dependent: :destroy

  # For likes of the user
  def total_likes(post)
    post.likes.count
  end

  def is_liked(user)
    Like.find_by(user_id: user.id, post_id: id)
  end
end
