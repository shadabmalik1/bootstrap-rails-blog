class Post < ActiveRecord::Base
	has_many :comments
	has_many :tags, through: :post_tags
  belongs_to :moderator

  def self.matching_title_or_content search
  	where("title LIKE ? OR content LIKE ?", "%#{search}%", "%#{search}%")
  end
end
