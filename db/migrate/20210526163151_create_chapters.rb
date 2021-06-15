class CreateChapters < ActiveRecord::Migration[6.1]
  def change
    create_table :chapters, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.string  :title
      t.integer :course_id

      t.timestamps
    end
  end
end
