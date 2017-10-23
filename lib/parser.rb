module Parser
  def self.run
    Site.all.each do |site|
      klass = "Parser::#{site.name}".constantize
      last_date = site.news.last_date

      klass.new(site, last_date).parse
    end
  end
end