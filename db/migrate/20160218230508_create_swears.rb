class CreateSwears < ActiveRecord::Migration
  def change
    create_table :swears do |t|
      t.references :language
      t.string :text
    end
  end
end
