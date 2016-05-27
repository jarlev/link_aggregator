class ChangeIntegerFormatInMyTable < ActiveRecord::Migration
  def change
    change_column :postvotes, :upvote, :boolean
    change_column :postvotes, :downvote, :boolean
  end
end
