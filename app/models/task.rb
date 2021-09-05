class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 300
  }
  enum progress: {未着手:0, 着手中:1, 完了:2}
  enum priority: {低:0, 中:1, 高:2}
  scope :sorted, -> { order(created_at: "DESC") }
  scope :sort_expired, -> { reorder(expired_at: "DESC") }
  scope :sort_priority, -> { reorder(priority: "DESC") }
  scope :title_like, -> (title) { where('title LIKE ?', "%#{title}%") }
  scope :progress, -> (progress) { where(progress: progress) }
  paginates_per 5
  belongs_to :user
end
