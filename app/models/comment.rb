class Comment < ApplicationRecord
  validates :author_id, :post_id, :text, presence: true
  validates :author_id, :post_id, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_comments_counter
  after_destroy :decrement_comments_counter

  def update_comments_counter
    post.increment!(:comments_counter)
  end

  def decrement_comments_counter
    post.decrement!(:comments_counter)
  end
end
