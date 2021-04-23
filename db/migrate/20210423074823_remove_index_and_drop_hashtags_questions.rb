class RemoveIndexAndDropHashtagsQuestions < ActiveRecord::Migration[6.1]
  def change
    remove_index :hashtags, :name
    drop_table :hashtags_questions
  end
end
