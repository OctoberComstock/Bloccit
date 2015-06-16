class AddDescriptionToSummaries < ActiveRecord::Migration
  def change
    add_column :summaries, :description, :string
  end
end
