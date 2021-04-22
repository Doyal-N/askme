class CreateHashtagsQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :hashtags_questions do |t|
      t.belongs_to :question
      t.belongs_to :hashtag
      t.timestamps
    end
  end
end
