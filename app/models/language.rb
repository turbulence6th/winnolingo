class Language < ActiveRecord::Base
  
  has_many :userLanguages, :dependent => :destroy
  has_many :users, :through => :userLanguages
  
  has_many :requestLanguages, :dependent => :destroy
  has_many :requests, :through => :requestLanguages
  
  has_many :questions, :dependent => :destroy
  
end
