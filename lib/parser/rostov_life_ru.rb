module Parser
  class RostovLifeRu < BaseParser
    attr_reader :site, :last_date

    def initialize(site, last_date)
      @site = site
      @last_date = last_date
    end

    def parse
      p "start #{self.class.to_s}"
      is_break = false

      # Get total pages on target site
      count_pages = scraper.total_count_pages("#{site.url}nenovosti/posts", container[:paginate])

      # Get news from all pages on target site
      count_pages.times do |i|
        links = scraper.get_page_links("#{site.url}/nenovosti/posts?page=#{i+1}", container[:link])

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
      @scraper ||= Parser::Helpers::DefaultDataParser.new(agent)
    end

    def container
      {
          paginate: 'article.b-content div.b-content__main div.b-pagination a:last',
          link: 'article.b-content div.b-content__main article.n-grid__column a',
          title: 'article.b-content h1.b-title',
          image: 'div.n-post-plate__pic2 span.img',
          date: 'article.b-content small.n-post-plate__panel__date',
          description: 'article.b-content section.n-post div.n-post__text'
      }
    end
  end
end