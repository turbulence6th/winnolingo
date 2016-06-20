class User < ActiveRecord::Base
  
  scope :valid, -> { where :deleted => false }
  
  has_secure_password
  
  has_many :requests, :dependent => :destroy
  has_many :suggestions, :dependent => :destroy
  
  has_many :userLanguages, :dependent => :destroy
  has_many :languages, :through => :userLanguages
  
  has_many :followers, :class_name => 'Follow', :foreign_key => 'followed_id', :dependent => :destroy
  has_many :followeds, :class_name => 'Follow', :foreign_key => 'follower_id', :dependent => :destroy
  
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
    :message => "Lütfen ad soyad / ünvan giriniz."
  }, :format => {
    :with => /\A[a-zA-Z\u00c7\u00e7\u011e\u011f\u0130\u0131\u00d6\u00f6\u015e\u015f\u00dc\u00fc ]*\z/,
    :message => "Sadece harf içerebilir."
  }, :length => {
    :minimum => 1,
    :maximum => 30,
    :message => "Lütfen 1 ve 30 karakter arasında bir ad soyad / ünvan kullanın."
  }
  
  validates :email, :presence => {
    :message => "Lütfen e-posta giriniz."
  }, :format => {
    :with => /\A[a-zA-Z0-9.]*@[a-zA-Z0-9.]*\z/,
    :message => "Lütfen geçerli bir e-posta giriniz."
  }, :uniqueness => { 
    :case_sensitive => false,
    :message => "Seçtiğiniz e-posta adresi zaten kullanılıyor."
  }, :if => :email_changed?
  
  validates :password, :presence => {
    :message => "Lütfen şifre giriniz."
  }, :format => {
    :with => /\A[a-zA-Z0-9_-]*\z/,
    :message => "Şifrenizde şunları kullanabilirsiniz: (a-z), (A-Z), rakamları ve - _ işaretlerini."
  }, :length => {
    :minimum => 6,
    :maximum => 30,
    :message => "Lütfen 6 ve 30 karakter arasında uzunluğa sahip bir şifre kullanın."
  }, :if => :password_digest_changed?
  
  validates :account_type, :presence => {
    :message => "Hesap tipi seçiniz."
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
