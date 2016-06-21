class Question < ActiveRecord::Base
  
  belongs_to :language
  
  validates :language, :presence => {
    :message => "Lütfen dil seçiniz."
  }
  
  validates :name, :presence => {
    :message => "Lütfen sorunuzu giriniz."
  }
  
  validates :right_answer_index, :presence => {
    :message => "Lütfen doğru şıkkın indexini giriniz."
  }
  
  validate :index_in_borders
  
  def index_in_borders
    if right_answer_index && (right_answer_index < 0 || answers.size <= right_answer_index)
      errors.add(:right_answer_index, "Geçersiz index değeri.")
    end
  end
  
  attr_accessor :answers_raw
  
  def answers_raw
    self.answers.join("\n") unless self.answers.nil?
  end

  def answers_raw=(values)
    self.answers = values.split("\r\n")
  end
  
end
