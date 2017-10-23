module Parser
  module Mytaganrog
    class MytaganrogData
      include Parser::Helpers::Methods

      def initialize(agent)
        @agent = agent
      end

      def total_count_pages(url, paginate_container)
        str = @agent.get(url).at(paginate_container).attr('href')
        str.scan(/\d+/).last.to_i rescue 1
      end

      def get_page_links(url, container_link)
        @agent.get(url).search(container_link)
      end

      def get_news_data(url, domain, options)
        info = { news:{}, photos:{} }
        page = @agent.get(url)

        info[:news][:title] = page.search(options[:title]).text.strip
        info[:news][:date] = page.search(options[:date]).text.strip
        info[:news][:description] = page.search(options[:description]).text.strip
        info[:news][:city_id] = get_city_id(info[:news][:title])

        image_node = page.search(options[:image])

        if image_node.present? && image_node.attr('class').present? && image_node.attr('class').value  == 'img'
          span_img = image_node.attr('style').value
          info[:news][:remote_image_url] = span_img.slice!(/http.*jpg/)
          info[:photos][:remote_photo_url] = [ info[:news][:remote_image_url] ]
        else
          info[:news][:remote_image_url] = get_image_url(image_node.attr('src').value, domain)

          info[:photos][:remote_photo_url] = []
          page.search(options[:image]).each { |node| info[:photos][:remote_photo_url] << get_image_url(node.attr('src'), domain) }
        end

        info
      end

      def get_date(str)
        ary = str.split
        day = ary.delete_at(0)
        month = ary.delete_at(1)

        rus_day_index = rus_weekdays.index(day)
        rus_month_index = rus_month.index(month)

        ary.insert(0, eng_weekdays[rus_day_index]) if rus_day_index
        ary.insert(2, eng_month[rus_month_index]) if rus_month_index
        ary.join(' ').to_datetime
      end

      private

      def get_city_id(str)
        match_region =  str.match(/ростовская/i) ||
                        str.match(/ростовскую/i) ||
                        str.match(/ростовской/i) ||
                        str.match(/таганрогская/i) ||
                        str.match(/таганрогскую/i) ||
                        str.match(/таганрогской/i) ||
                        str.match(/таганрогом/i) ||
                        str.match(/ростовом/i)

        match_city = (str.match(/ростов/i) || str.match(/таганрог/i))
        return if match_region

        City.find_by_name(match_city.to_s).id rescue nil
      end


      def get_image_url(str, domain)
        str.split('/')[0] == '' ? (domain + str) : str
      end
    end
  end
end