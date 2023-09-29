class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  def post_counter_updates
    author.update(posts_counter: author.posts.count)
  end

  def latest_comments
    comments.order(created_at: :desc).limit(5)
  end

  default_scope { order(created_at: :desc) }

  after_create :post_counter_updates
  after_destroy :post_counter_updates
end
