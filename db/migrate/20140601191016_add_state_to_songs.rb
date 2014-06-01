class AddStateToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :state, :string
  end
end
