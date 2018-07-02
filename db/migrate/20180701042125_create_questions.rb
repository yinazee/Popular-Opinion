class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :topic
      t.string :content
      t.string :choice1
      t.string :choice2
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
