class CreateChapters < ActiveRecord::Migration[6.1]
  def change
    create_table :chapters do |t|
      t.text :title
      t.integer :course_id

      t.timestamps
    end
  end
end
