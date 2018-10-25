class CreateInterviews < ActiveRecord::Migration[5.1]
  def change
    create_table :interviews do |t|
      t.datetime :schedule, null: false
      t.text :note
      t.integer :status, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :interviews, [:user_id, :schedule]
    add_index :interviews, [:status]
  end
end
