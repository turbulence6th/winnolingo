class Session < ActiveRecord::Base
  
  after_initialize :after_initialize
  
  belongs_to :user 
  
  enum :device_type => {
    :android => 0,
    :ios => 1,
    :browser => 2
  }
  
  def after_initialize
    self.auth_token = SecureRandom.uuid
  end
  
end
