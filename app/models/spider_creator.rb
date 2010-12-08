class SpiderCreator
  def initialize(section)
    @section = section
  end

  def generate
    spider = SpiderParser.new(@section)
    xml = XmlGenerator.new

    result = xml.to_s + xml.add_tournament(spider.tournament)

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
    result += xml.close_tournament_tag + xml.close_tag
    result
  end
end
