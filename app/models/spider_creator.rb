class SpiderCreator
  def initialize(url, section, parser, subdomain)
    @url, @section, @parser, @subdomain = url, section, parser, subdomain
  end

  def generate
    xml = XmlGenerator.new
    result = xml.to_s
    eval(@parser).url = @url
    eval(@parser).subdomain = @subdomain

    @section.each do |section|
      spider = eval(@parser).new(section)

      tournament = spider.tournament

      if not tournament.empty?
        result += xml.add_tournament(spider.tournament)

        #выбираем команды, события и ставки
        competitions = spider.team
        events = spider.event
        factors = spider.factor

        competitions.each_with_index do |item, index|
          result += xml.add_competition(item[0], item[1])
          events.each_with_index do |event, event_index|
            result += xml.add_event(event, factors[index][event_index])
          end
          result += xml.close_competition_tag
        end

        result += xml.close_tournament_tag
      end
    end
    
    result += xml.close_tag
  end
end
