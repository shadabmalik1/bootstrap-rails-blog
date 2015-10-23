class Message < ActiveRecord::Base

  belongs_to :visitor

  validates :content, presence: true

  def self.matching_content_or_fullname search
  	Message.joins(:visitor).where("content like ? OR fullname like ?", "%#{search}%", "%#{search}%")
  end
end
