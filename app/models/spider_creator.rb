class SpiderCreator
  def initialize(section)
    @section = section
  end

  def generate
    xml = XmlGenerator.new
    result = xml.to_s
    @section.each do |url|
      spider = SpiderParser.new(url)
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
    end
    
    result += xml.close_tag
  end
end
