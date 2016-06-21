class Request < ActiveRecord::Base
  
  scope :valid, -> { 
    where(:deleted => false)
  }
  
  scope :not_blocked, ->(current_user) {
    where(Block.where("blocks.blocker_id=? AND " +
      "blocks.blocked_id=requests.user_id", current_user.id).exists.not) if current_user
  }
  
  belongs_to :user
  has_many :suggestions, :dependent => :destroy
  has_many :requestLanguages, :dependent => :destroy
  has_many :languages, :through => :requestLanguages
  
  enum :category => {
    :commercial => 0,
    :social => 1,
    :art => 2,
    :scientific => 3
  }
  
  validates :user, :presence => {
    :message => I18n.translate("request.user.presence")
  }
  
  validates :category, :presence => {
    :message => I18n.translate("request.category.presence")
  }
  
  validates :name, :presence => {
    :message => I18n.translate("request.name.presence")
  }, :length => {
    :minimum => 3,
    :maximum => 50,
    :message => I18n.translate("request.name.length")
  }
  
  validates :award, :presence => {
    :message => I18n.translate("request.award.presence")
  }, :length => {
    :minimum => 3,
    :maximum => 50,
    :message => I18n.translate("request.award.length")
  }
  
  validates :description, :length => {
    :maximum => 500,
    :message => I18n.translate("request.description.length")
  }
  
end
