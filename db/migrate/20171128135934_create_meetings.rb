class CreateMeetings < ActiveRecord::Migration[5.1]
  def change
    create_table :meetings do |t|
      t.date :date
      t.time :time
      t.references :user_one, foreign_key: { to_table: :users }
      t.references :user_two, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
