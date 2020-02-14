class AddCategoryColumnToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :category_num, :integer
  end
end
