class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post

  def likes_counter_updates
    post.update(likes_counter: post.likes.count)
  end

  after_create :likes_counter_updates
  after_destroy :likes_counter_updates
end
