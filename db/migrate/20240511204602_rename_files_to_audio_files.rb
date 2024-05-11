class RenameFilesToAudioFiles < ActiveRecord::Migration[7.1]
  def change
    rename_table :files, :audio_files
  end
end
