class Suggestion < ActiveRecord::Base
  
  scope :valid, -> { where :deleted => false }
  
  belongs_to :user
  belongs_to :request
  
  validates :user, :presence => {
    :message => "Öneride bulunmak için oturum açmanız gerekmektedir."
  }
  
  validates :request, :presence => {
    :message => "Yaptığınız öneriye ait talep bulunamadı."
  }
  
  validates :text, :presence => {
    :message => "Öneri yapmak zorundasınız."
  }, :length => {
    :maximum => 100,
    :message => "Öneriniz en fazla 100 karakterden oluşabilir."
  }
  
  validates :text, :uniqueness => {
    :message => "Göndermek istediğiniz öneri daha önce bir başka kullanıcı tarafından önerildi."
  }, :if => "!deleted"
  
  validate :own_request, :suggestion_count
  
  def own_request
    if request && request.user == user
      errors.add(:request, "Kendi talebinize öneride bulunamazsınız.")
    end
  end
  
  def suggestion_count
    if Suggestion.where(:user => user, :request => request).count >= 5
      errors.add(:request, "Talebe en fazla 5 öneride bulunabilirsiniz.")
    end
  end
  
end
