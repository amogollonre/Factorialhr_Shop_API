class ApplicationSerializer < ActiveModel::Serializer
    def created_at
      object.created_at.iso8601
    end
  
    def updated_at
      object.updated_at.iso8601
    end
  end