require 'builder'
require 'iconv'

class MarathonParser

  cattr_accessor :url
  cattr_accessor :subdomain
  
  @@competition_count = 0
  @@url = ''

  def initialize(section)
#    converted = Iconv.iconv('utf-8', 'cp1251', login)
    @doc = login.parser
  end

  def part(xpath)
    res = Array.new
    @doc.xpath(xpath).each do |link|
      res << link.content

      Rails.logger.info link.content
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
    # /html/body/div[3]/div/form/a/div
    part('/html/body/div#container')
  end

  protected

    def login
      a = Mechanize.new { |agent|
        agent.user_agent_alias = 'Mac Safari'
      }
      a.get('https://www.marathonbet.com/login.phtml?check=1&rurl=http%3A%2F%2Fodds.marathonbet.com%2Fodds.phtml') do |page|
        login_result = page.form_with(:action => 'https://www.marathonbet.com/login.phtml?check=1&rurl=http%3A%2F%2Fodds.marathonbet.com%2Fodds.phtml') do |f|
          f.plog = '458206'
          f.ppwd = '1234!56'
        end.submit

        login_result
      end
    end
end
