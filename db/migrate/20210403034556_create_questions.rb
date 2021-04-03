class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :text, null: false, length: 255
      t.text :answer, null: false

      t.timestamps
    end
  end
end
