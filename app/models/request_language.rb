class RequestLanguage < ActiveRecord::Base
  
  belongs_to :request
  belongs_to :language
  
end
