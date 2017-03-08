class AddCommitedBack < ActiveRecord::Migration
  def up
    # For some reason, enabling the polls didn't convert all the
    # motions, making them disappear
    Group.all.find_each do |group|
      next unless group.features['use_polls']

      puts "Migrating Group ##{group.id} with #{group.motions.count} Motions"
      PollService.convert(motions: group.motions)
    end

    puts "Migrating #{Poll.where(poll_type: 'proposal').count} Polls"
    Poll.where(poll_type: 'proposal').find_each do |poll|
      # Skip already migrated
      next if poll.poll_option_names.include? 'commited'
      # wtf
      next unless poll.motion.present?

      puts "Migrating Poll ##{poll.id}"

      Poll.transaction do
        # Ensure commited is always the first option, otherwise the
        # charts get messed up colors
        poll_option = poll.poll_options.create(name: 'commited', priority: -1)
        poll.motion.votes.each do |vote|
          # Other stances are already created
          next unless vote.position == 'commited'

          # Copied from PollService.convert
          poll.stances << Stance.new(
            stance_choices:   [StanceChoice.new(poll_option: poll_option)],
            participant_type: 'User',
            participant_id:   vote.user_id,
            reason:           vote.statement,
            latest:           vote.age.zero?,
            created_at:       vote.created_at,
            updated_at:       vote.updated_at
          )
        end

        poll.save
        # Update the data so the charts are correct
        poll.update_stance_data
      end
    end
  end

  def down
    PollOption.where(name: 'commited').delete_all
    # XXX: Too lazy to do rollbacks here
  end
end
