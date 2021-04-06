class ChangeColumnNullToTableQuestions < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:questions, :answer, true)
  end
end
