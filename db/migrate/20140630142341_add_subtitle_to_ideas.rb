class AddSubtitleToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :subtitle, :string
  end
end
