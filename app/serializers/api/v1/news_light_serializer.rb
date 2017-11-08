module Api
  module V1
    class NewsLightSerializer < ActiveModel::Serializer
      attributes :id, :title, :description
      has_many :photos, serializer: PhotosSerializer
    end
  end
end