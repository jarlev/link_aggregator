class RemoveColumnRatingFromComments < ActiveRecord::Migration
  def change
	  remove_column :comments, :rating

  end
end
