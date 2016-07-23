class AddCommitedCountToMotion < ActiveRecord::Migration
  def change
    # Estamos trayendo la migración desde otra rama, y algunos deploys
    # ya la tienen implementada
    unless column_exists? :motions, :commited_votes_count
      add_column :motions, :commited_votes_count, :integer, null: false, default: 0
    end
  end
end
