class User < ActiveRecord::Base
  
  has_many :requests
  has_many :suggestions
  
  has_many :userLanguages
  
end
