class Follow < ActiveRecord::Base
  
  belongs_to :follower, :class_name => 'User'
  belongs_to :followed, :class_name => 'User'
  
  validates :follower, :presence => {
    :message => I18n.translate("follow.follower.presence")
  }
  
  validates :followed, :presence => {
    :message => I18n.translate("follow.followed.presence")
  }, :uniqueness => {
    :message => I18n.translate("follow.followed.uniqueness")
  }
  
  validate :self_follow
  
  def self_follow
    if follower && follower == followed
      errors.add(:followed, I18n.translate("follow.followed.self"))
    end
  end
  
end
