class CreateCourseUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :course_users do |t|
      t.references :user
      t.references :course
      t.datetime :end_at

      t.timestamps
    end
  end
end
