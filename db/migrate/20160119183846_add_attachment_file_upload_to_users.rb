class AddAttachmentFileUploadToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :file_upload
    end
  end

  def self.down
    remove_attachment :users, :file_upload
  end
end
