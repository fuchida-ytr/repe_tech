class CreateReviewSections < ActiveRecord::Migration[6.1]
  def change
    create_table :review_sections do |t|
      t.date    :next_review_date
      # t.date    :prev_review_date # 正解するまで復習したい場合に使用
      t.integer :correct_answers_num,   default: 0
      t.integer :incorrect_answers_num, default: 0
      t.integer :review_stage_id
      t.references :user, null: false, foreign_key: true
      t.references :section, null: false, foreign_key: true

      t.timestamps
    end
  end
end

