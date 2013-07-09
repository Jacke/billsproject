class DeviseCreateEmployees < ActiveRecord::Migration
  def self.up
    create_table(:employees) do |t|
    	t.string :name
    	t.integer :phone
    	t.boolean :admin
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      
      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end

    add_index :employees, :email,                :unique => true
    add_index :employees, :reset_password_token, :unique => true
    # add_index :cashiers, :confirmation_token,   :unique => true
    # add_index :cashiers, :unlock_token,         :unique => true
    # add_index :cashiers, :authentication_token, :unique => true
  end

  def self.down
    drop_table :employees
  end
end
