class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.boolean :public, default: true

      t.timestamps
    end
  end
end
