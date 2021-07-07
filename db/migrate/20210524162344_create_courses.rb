class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses, options: 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.string :title
      t.text   :caption
      t.text   :image_id

      t.timestamps
    end
  end
end
