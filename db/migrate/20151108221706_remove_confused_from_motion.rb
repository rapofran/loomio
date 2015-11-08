class RemoveConfusedFromMotion < ActiveRecord::Migration
  def change
    remove_column :motions, :confused_votes_count, :integer, null: false
  end
end
