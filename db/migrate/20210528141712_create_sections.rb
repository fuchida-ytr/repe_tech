class CreateSections < ActiveRecord::Migration[6.1]
  def change
    create_table :sections, options: 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.string  :title
      t.text    :content
      t.integer :chapter_id

      t.timestamps
    end
  end
end
