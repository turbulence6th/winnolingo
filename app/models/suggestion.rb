class Suggestion < ActiveRecord::Base
  
  scope :valid, -> { 
    where(:deleted => false)
  }
  
  scope :not_blocked, ->(current_user) {
    where(Block.where("blocks.blocker_id=? AND " +
      "blocks.blocked_id=suggestions.user_id", current_user.id).exists.not) if current_user
  }
  
  belongs_to :user
  belongs_to :request
  
  validates :user, :presence => {
    :message => I18n.translate("suggestion.user.presence")
  }
  
  validates :request, :presence => {
    :message => I18n.translate("suggestion.request.presence")
  }
  
  validates :text, :presence => {
    :message => I18n.translate("suggestion.text.presence")
  }, :length => {
    :maximum => 100,
    :message => I18n.translate("suggestion.length.presence")
  }
  
  validates :text, :uniqueness => {
    :message => I18n.translate("suggestion.text.uniqueness")
  }, :if => "!deleted"
  
  validate :own_request, :suggestion_count
  
  def own_request
    if request && request.user == user
      errors.add(:request, I18n.translate("suggestion.request.own"))
    end
  end
  
  def suggestion_count
    if Suggestion.where(:user => user, :request => request).count >= 5
      errors.add(:request, I18n.translate("suggestion.request.count"))
    end
  end
  
end
