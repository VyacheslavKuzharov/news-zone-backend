module Api
  module V1
    class NewsController < Api::ApiBaseController
      extend Controllers::ApiDoc
      expose_doc

      def index
        news = News.includes([:site, :region])
                   .order('in_top desc, date desc')
                   .page(page)

        success_response!(news, NewsSerializer, page: page, total_pages: news.total_pages)
      end

      def show
        news = News.find_by_id(params[:id])
        success_response!(news, NewsLightSerializer)
      rescue => error
        throw_error!(type_for(error), status: :not_found, id: params[:id])
      end

      private

      def page
        params[:page] || 1
      end
    end
  end
end