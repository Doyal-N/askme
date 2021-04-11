class AddColumnAuthorToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :author_id, :integer, null: true
    add_index :questions, :author_id, where: 'author_id IS NOT NULL'
  end
end
