class AddFieldsToPostvotes < ActiveRecord::Migration
  def change
    add_column :postvotes, :upvote, :integer
    add_column :postvotes, :downvote, :integer
  end
end
