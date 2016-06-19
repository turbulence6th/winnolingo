class Request < ActiveRecord::Base
  
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
    :message => "Talep oluşturmak için oturum açmanız gerekmektedir."
  }
  
  validates :category, :presence => {
    :message => "Lütfen kategori seçiniz."
  }
  
  validates :name, :presence => {
    :message => "Lütfen talep adı giriniz."
  }, :length => {
    :minimum => 3,
    :maximum => 50,
    :message => "Lütfen 3 ve 50 karakter arasında uzunluğa sahip talep adı giriniz."
  }
  
  validates :award, :presence => {
    :message => "Lütfen ödül giriniz."
  }, :length => {
    :minimum => 3,
    :maximum => 50,
    :message => "Lütfen 3 ve 50 karakter arasında uzunluğa sahip ödül giriniz."
  }
  
  validates :description, :length => {
    :maximum => 500,
    :message => "Lütfen 500 karakterden kısa bir açıklama giriniz."
  }
  
end
