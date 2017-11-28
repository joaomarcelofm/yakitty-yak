class CreateMeetings < ActiveRecord::Migration[5.1]
  def change
    create_table :meetings do |t|
      t.date :date
      t.time :time
      t.references :user, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
