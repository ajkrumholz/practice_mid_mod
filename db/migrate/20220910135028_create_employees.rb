class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.belongs_to :department, foreign_key: true
      t.string :name
      t.integer :level
      t.timestamps
    end
  end
end
