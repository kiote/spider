require 'builder'
class SpiderParser
  URL = 'http://leonbets.ru/'
  @@competition_count = 0

  def initialize(section)
    @doc = Nokogiri::HTML(open(URL + section))
  end

  def part(xpath)
    res = Array.new
    @doc.xpath(xpath).each do |link|
      res << link.content if link.content.include? "-"
    end
    
    res
  end

  def team
    competiotions = part('/html/body/div/div/div[3]/div/div/table/tr/td/table/tr/td[3]/table[2]/tr/td[2]/strong/a')
    @@competition_count = competiotions.count
    result = Array.new

    competiotions.each do |competiotion|
      arr = Array.new
      competiotion.split('-').each do |team|
        team.gsub!(" ", '')
        team.gsub!("\r\n", '')
        arr << team
      end
      result << arr
    end

    result
  end

  def event
    ["Поб. 1", "Ничья Х", "Поб. 1"]
  end

  def factor
    factors = part('/html/body/div/div/div[3]/div/div/table/tr/td/table/tr/td[3]/table[2]/tr')

    temp_arr = Array.new
    factors.each do |factor|
      factor.gsub!("\r\n", "")
      maybe = factor.split(" ")

      maybe = maybe.select {|v| v =~ /^\d+\.\d+$/}
      temp_arr << maybe
    end

    result = Array.new
    temp_arr.each do |res|
      result << res if res.size == 3
    end

    result
  end

  def tournament
    part('/html/body/div/div/div[3]/div/div/table/tr/td/table/tr/td[3]/table/tr/td[2]/span')
  end
end
