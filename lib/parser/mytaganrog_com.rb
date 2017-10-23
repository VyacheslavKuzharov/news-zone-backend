module Parser
  class MytaganrogCom < BaseParser

    attr_reader :site, :last_date

    def initialize(site, last_date)
      @site = site
      @last_date = last_date
    end

    def parse
      p "start #{self.class.to_s}"
      is_break = false

      # Get total pages on target site
      count_pages = scraper.total_count_pages( site.url, container[:paginate] )

      # Get news from all pages on target site
      count_pages.times do |i|
        # Find news urls on the current page
        links = scraper.get_page_links("#{site.url}/?page=#{i}", container[:link] )

        # Get current news data
        links.each do |link|
          href = link.attr('href')
          path = "#{site.url}#{href}"
          domain = site.url

          data = scraper.get_news_data(path, domain, container)

          data[:news][:site_id] = site.id
          data[:news][:url] = "#{site.url[0...-1]}#{href}"
          data[:news][:region_id] = region(I18n.t('regions.rostov_region')).id
          data[:news][:date] = scraper.get_date(data[:news][:date]).to_datetime

          if data[:news][:date] > last_date
            save_news_and_photos(data[:news], data[:photos])
          else
            is_break = true
            break
          end
        end
        break if is_break
      end
      p "done #{self.class.to_s}"
    end

    private

    def scraper
      @scraper ||= Parser::Mytaganrog::MytaganrogData.new(agent)
    end

    def container
      {
          paginate: 'div#main-wrapper div#main-content div.item-list ul.pager li.pager-last a',
          link: 'div#main-content div.block-content div.article h2.node-title a',
          title: 'div#main-wrapper div#main-content h1#page-title',
          image: 'div#main-content div.region-content div#block-system-main div.field-items p.rtecenter img',
          date: 'div#main-content div.footer span.pubdate',
          description: 'div#main-content div.region-content div#block-system-main div.field-items div.field-item p'
      }
    end
  end
end