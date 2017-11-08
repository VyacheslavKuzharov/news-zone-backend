module Api
  module V1
    class PhotosSerializer < ActiveModel::Serializer
      attributes :id, :url

      def url
        object.photo_url
      end
    end
  end
end
