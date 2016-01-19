class AddAttachmentFileUploadToItems < ActiveRecord::Migration
  def self.up
    change_table :items do |t|
      t.attachment :file_upload
    end
  end

  def self.down
    remove_attachment :items, :file_upload
  end
end
