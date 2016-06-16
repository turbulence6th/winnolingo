class CreateRequestLanguages < ActiveRecord::Migration
  def change
    create_table :request_languages do |t|
      t.references :request
      t.references :language
    end
  end
end
