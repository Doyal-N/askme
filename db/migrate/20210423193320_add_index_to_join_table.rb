class AddIndexToJoinTable < ActiveRecord::Migration[6.1]
  def change
    add_index :hashtag_questions, [:question_id, :hashtag_id]
  end
end
