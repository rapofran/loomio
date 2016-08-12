class Privacidad < ActiveRecord::Migration
  def change
    [:sign_in_count, :current_sign_in_at, :last_sign_in_at,
     :current_sign_in_ip, :last_sign_in_ip].each do |column|

      remove_column :users, column if column_exists? :users, column
    end
  end
end
