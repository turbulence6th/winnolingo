class Block < ActiveRecord::Base
  
  belongs_to :blocker, :class_name => 'User'
  belongs_to :blocked, :class_name => 'User'
  
  validates :blocker, :presence => {
    :message => "Kullanıcıyı engellemek için önce oturum açmalısınız."
  }
  
  validates :blocked, :presence => {
    :message => "Engellemek istediğiniz kullanıcı bulunamadı."
  }
  
  validate :self_block
  
  def self_block
    if blocker == blocked
      errors.add(:blocked, "Kendi kendinizi engelleyemezsiniz.")
    end
  end
  
end
