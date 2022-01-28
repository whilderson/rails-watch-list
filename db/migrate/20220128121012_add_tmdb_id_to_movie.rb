class AddTmdbIdToMovie < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :tmdb_id, :integer
  end
end
