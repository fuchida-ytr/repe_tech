class CreateSections < ActiveRecord::Migration[6.1]
  def change
    create_table :sections do |t|
      t.string  :title
      t.text    :content
      t.integer :chapter_id

      t.timestamps
    end
  end
end
