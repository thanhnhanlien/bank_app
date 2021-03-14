class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      ## Database authenticatable
      t.string :name, null: false, default: ""
      t.string :bank, null: false, default: ""

      ## Recoverable
      t.integer  :user_id
      t.timestamps
    end
  end
end
