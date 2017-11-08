module Api
  class SuccessPayload
    attr_reader :resource, :serializer, :attr

    def initialize(resource, serializer, attr)
      @resource = resource
      @serializer = serializer
      @attr = attr
    end

    def as_json(*)
      {
          meta: attr,
          data: target_data
      }
    end


    private

    def target_data
      ActiveModelSerializers::SerializableResource.new(resource, default_serializer)
    end

    def default_serializer
      { each_serializer: serializer, adapter: :json }.reject { |k, v| v.nil? }
    end
  end
end