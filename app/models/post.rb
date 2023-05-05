class Post < ApplicationRecord
  validates :author_id, :title, :text, :comments_counter, :likes_counter, presence: true
  validates :title, length: { maximum: 250 }
  validates :comments_counter, :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  after_save :update_post_counter

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_post_counter
    author.increment!(:postscounter)
  end
end
