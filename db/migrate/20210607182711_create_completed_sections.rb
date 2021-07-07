class CreateCompletedSections < ActiveRecord::Migration[6.1]
  def change
    create_table :completed_sections, options: 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.references :user, null: false, foreign_key: true
      t.references :section, null: false, foreign_key: true

      t.timestamps
    end
  end
end
