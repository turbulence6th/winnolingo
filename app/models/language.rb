class Language < ActiveRecord::Base
  
  has_many :userLanguages, :dependent => :destroy
  has_many :requestLanguages, :dependent => :destroy
  has_many :questions, :dependent => :destroy
  
end
