class CreateReviewStages < ActiveRecord::Migration[6.1]
  def change
    create_table :review_stages, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.integer :stage
      t.integer :after_days
      t.integer :user_id

      t.timestamps
    end
  end
end
