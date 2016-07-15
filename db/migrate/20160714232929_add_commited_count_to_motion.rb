class AddCommitedCountToMotion < ActiveRecord::Migration
  def change
    add_column :motions, :commited_votes_count, :integer, null: false, default: 0
  end
end
