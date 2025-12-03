ActiveSupport.on_load(:active_storage_attachment) do
  class ActiveStorage::Attachment
    def self.ransackable_attributes(auth_object = nil)
      ["id", "name", "record_type", "record_id", "blob_id", "created_at"]
    end

    def self.ransackable_associations(auth_object = nil)
      ["blob"]
    end
  end
end

ActiveSupport.on_load(:active_storage_blob) do
  class ActiveStorage::Blob
    def self.ransackable_attributes(auth_object = nil)
      ["id", "key", "filename", "content_type", "byte_size", "created_at"]
    end

    def self.ransackable_associations(auth_object = nil)
      []
    end
  end
end