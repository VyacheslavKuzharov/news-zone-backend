module Parser
  class BaseParser
    I18n.locale = :ru

    def region(name)
      @region ||= Region.find_by_name(name)
    end

    def agent
      @agent ||= Mechanize.new
    end

    def save_news_and_photos(news, photos)
      record = News.create!(news)
      photos[:remote_photo_url].each { |photo| record.photos.create(remote_photo_url: photo) } unless photos[:remote_photo_url].nil?
      p "news and photos for: #{record.title}, is saved..."
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "Parser::BaseParser ERROR! Message: #{e}."
    end
  end
end