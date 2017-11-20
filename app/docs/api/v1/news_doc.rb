module Api
  module V1
    class NewsDoc < ApplicationDoc
      resource_description do
        description 'Latest News'
      end

      doc_for :index do
        api :GET, '/v1/news', 'News list'

        description 'method description'
        formats ['json']
        meta 'Authorization header is required. Format: Authorization Bearer qwerty'


        error code: 401, desc: 'Unauthorized', meta: {token: 'is required'}

        param :page, Integer, desc: 'Page number. api/v1/news?page=1'
        example "
          {
            'meta': {
            'page': '1',
            'total_pages': 3
          },
          'data': {
              'news': [
                  {
                    'id': 9,
                    'title': 'News title',
                    'description': 'News Description(truncated)'
                  },
                  {
                    'id': 34,
                    'title': 'News title',
                    'description': 'News Description(truncated)'
                  }
              ]
          }
        "
      end

      doc_for :show do
        api :GET, '/v1/news/:id', 'Show specific news details'

        description 'method description'
        formats ['json']
        meta 'Authorization header is required. Format: Authorization Bearer qwerty'

        error code: 401, desc: 'Unauthorized', meta: {token: 'is required'}
        error code: 404, desc: 'Not Found'

        param :id, Integer, desc: 'news id', required: true
        example "
          {
            'meta': {},
            'data': {
                'news': {
                    'id': 31,
                    'title': 'News title',
                    'description': 'News description(full)',
                    'photos': [
                        {
                            'url': 'http://res.cloudinary.com/dawid4qiq/image/upload/v1508874737/pbtl22gvekihhiq3typg.jpg'
                        },
                        {
                            'url': 'http://res.cloudinary.com/dawid4qiq/image/upload/v1508874740/gu56mx3r2tt2iha4fo3c.jpg'
                        }
                    ]
                }
            }
        "
      end
    end
  end
end