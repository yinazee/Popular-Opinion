class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :backstory
      t.string :question
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
