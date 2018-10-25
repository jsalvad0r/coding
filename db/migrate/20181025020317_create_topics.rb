class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :title
      t.string :link_video
      t.references :course

      t.timestamps
    end
  end
end
