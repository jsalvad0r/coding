class CreateInterestUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :interest_users do |t|
      t.references :user
      t.references :interest

      t.timestamps
    end
  end
end
