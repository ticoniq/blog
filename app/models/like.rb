class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :likes_counter_updates

  def likes_counter_updates
    post.increment!(:likes_counter)
  end
end
