class ChangeIntegerFormatInMyTable < ActiveRecord::Migration
  def change
    change_column :postvotes, :upvote, 'boolean USING CAST("upvote" AS boolean)'
    change_column :postvotes, :downvote, 'boolean USING CAST("downvote" AS boolean)'
  end
end
