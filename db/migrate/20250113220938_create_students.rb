class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.string :student_name
      t.string :parent_name
      t.string :grade
      t.string :teachers
      t.string :sports
      t.string :form_name
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
