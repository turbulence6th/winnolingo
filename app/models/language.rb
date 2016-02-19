class Language < ActiveRecord::Base
  
  has_many :userLanguages, :dependent => :destroy
  
end
