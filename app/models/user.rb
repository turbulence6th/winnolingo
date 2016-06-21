class User < ActiveRecord::Base
  
  scope :valid, -> { 
    where(:deleted => false)
  }
  
  scope :not_blocked, ->(current_user) {
    where(Block.where("blocks.blocker_id=? AND " +
      "blocks.blocked_id=users.id", current_user.id).exists.not) if current_user
  }
  
  has_secure_password
  
  has_many :requests, :dependent => :destroy
  has_many :suggestions, :dependent => :destroy
  
  has_many :userLanguages, :dependent => :destroy
  has_many :languages, :through => :userLanguages
  
  has_many :followers_follow, :class_name => 'Follow', :foreign_key => 'followed_id', :dependent => :destroy
  has_many :followers, :through => :followers_follow, :source => :follower
  
  has_many :followeds_follow, :class_name => 'Follow', :foreign_key => 'follower_id', :dependent => :destroy
  has_many :followeds, :through => :followeds_follow, :source => :followed
  
  has_many :blockers_block, :class_name => 'Block', :foreign_key => 'blocked_id', :dependent => :destroy
  has_many :blockers, :through => :blockers_block, :source => :blocker
  
  has_many :blockeds_block, :class_name => 'Block', :foreign_key => 'blocker_id', :dependent => :destroy
  has_many :blockeds, :through => :blockeds_block, :source => :blocked
  
  has_many :sessions
  
  enum :role => {
    :admin => 0,
    :member => 1
  }
  
  enum :account_type => {
    :male => 0,
    :female => 1,
    :company => 2,
    :public_institution => 3,
    :foundatition => 4,
    :non_profit_organisation => 5,
    :educational_institution => 6
  }
  
  validates :name, :presence => {
    :message => I18n.translate("user.name.presence")
  }, :format => {
    :with => /\A[a-zA-Z\u00c7\u00e7\u011e\u011f\u0130\u0131\u00d6\u00f6\u015e\u015f\u00dc\u00fc ]*\z/,
    :message => I18n.translate("user.name.format")
  }, :length => {
    :minimum => 1,
    :maximum => 30,
    :message => I18n.translate("user.name.length")
  }
  
  validates :email, :presence => {
    :message => I18n.translate("user.email.presence")
  }, :format => {
    :with => /\A[a-zA-Z0-9.]*@[a-zA-Z0-9.]*\z/,
    :message => I18n.translate("user.email.format")
  }, :uniqueness => { 
    :case_sensitive => false,
    :message => I18n.translate("user.email.uniqueness")
  }, :if => :email_changed?
  
  validates :password, :presence => {
    :message => I18n.translate("user.password.presence")
  }, :format => {
    :with => /\A[a-zA-Z0-9_-]*\z/,
    :message => I18n.translate("user.password.format")
  }, :length => {
    :minimum => 6,
    :maximum => 30,
    :message => I18n.translate("user.password.length")
  }, :if => :password_digest_changed?
  
  validates :account_type, :presence => {
    :message => I18n.translate("user.account_type.presence")
  }
  
  public
  def if_social_exists
    self.facebook_id.present? || self.google_id.present? || self.twitter_id.present?
  end
  
  def kind
    if self.account_type == 'male' || self.account_type == 'female'
      :real_person
    else
      :legal_person
    end
  end
  
  def user_types
    titles = []
    successful_suggestions = self.suggestions.where(:successful => true).count
    if successful_suggestions >= 50
      titles << {:name => "Linguru", :points => successful_suggestions}
    end
    
    created_requests = self.requests.count
    if self.account_type == User.account_types[:company] && created_requests >= 1
      titles << {:name => "Müşteri Odaklı Şirket", :points => created_requests}
    elsif (self.account_type == User.account_types[:public_institution] || 
        self.account_type == User.account_types[:foundatition] ||
        self.account_type == User.account_types[:non_profit_organisation] ||
        self.account_type == User.account_types[:educational_institution]) && 
        created_requests >= 1
      titles << {:name => "Kamuoyu Odaklı Kurum", :points => created_requests}
    elsif (self.account_type == User.account_types[:male] ||
        self.account_type == User.account_types[:female]) && created_requests >= 1
      titles << {:name => "Yeni Fikirlere İlgi Duyuyor", :points => created_requests}
    end
    
    titles
  end
  
end
