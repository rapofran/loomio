class AddPartitionToMotions < ActiveRecord::Migration
  def change
    add_column :motions, :participation_votes_count, :integer, default: 0, null: false
    add_column :motions, :confusing_votes_count, :integer, default: 0, null: false
  end
end
