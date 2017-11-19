module Api
  class ApiBaseController < ApplicationController
    before_action :authenticate_user!

    rescue_from ActiveRecord::RecordNotFound do |e|
      throw_error!(:record_not_found, status: :not_found, message: e.message.downcase.capitalize)
    end


    private

    def success_response!(resource, serializer, status: :ok, **attr)
      render json: Api::SuccessPayload.new(resource, serializer, attr), status: status
    end

    def throw_error!(identifier, status: :forbidden, **attr)
      render json: Api::ErrorPayload.new(identifier, status, attr), status: status
    end

    def type_for(e)
      e.is_a?(Class) ? e.to_s.split('::').last.underscore : e.class.to_s.underscore
    end
  end
end