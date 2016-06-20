class CreateRequestLanguages < ActiveRecord::Migration
  def change
    create_table :request_languages do |t|
      t.references :request, :index => true
      t.references :language, :index => true
    end
  end
end
