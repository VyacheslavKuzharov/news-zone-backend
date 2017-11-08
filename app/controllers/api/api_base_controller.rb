module Api
  class ApiBaseController < ApplicationController
    rescue_from StandardError do |e|
      throw_error!(:internal_server_error, status: :internal_server_error, message: e.message.downcase.capitalize)
    end


    private

    def success_response!(resource, serializer, status: :ok, **attr)
      render json: Api::SuccessPayload.new(resource, serializer, attr), status: status
    end

    def throw_error!(identifier, status: :forbidden, **attr)
      render json: Api::ErrorPayload.new(identifier, status, attr), status: status
    end

    def type_for(e)
      e.class.to_s.underscore
    rescue
      :internal_server_error
    end
  end
end