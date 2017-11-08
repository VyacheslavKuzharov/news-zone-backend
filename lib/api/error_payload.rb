module Api
  class ErrorPayload
    attr_reader :identifier, :status, :attr

    def initialize(identifier, status, attr)
      @identifier = identifier
      @status = status
      @attr = attr
    end

    def as_json(*)
      {
          status: Rack::Utils.status_code(status),
          source: identifier,
          title: I18n.t("errors.#{identifier}.title"),
          detail: I18n.t("errors.#{identifier}.detail", attr)
      }
    end
  end
end