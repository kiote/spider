class XmlGenerator
  def initialize
    @body = '<?xml version="1.0" encoding="UTF-8"?><line>'
  end

  def add_event(name, factor)
    "<event name = \"#{name}\" factor = \"#{factor}\"/>"
  end

  def add_competition(team1, team2)
    "<competition team1=\"#{team1}\" team2=\"#{team2}\">"
  end

  def add_tournament(tournament)
    "<tournament name=\"#{tournament}\">"
  end

  def close_tournament_tag
    "</tournament>"
  end

  def close_competition_tag
    "</competition>"
  end

  def close_tag
    "</line>"
  end

  def to_s
    @body
  end
end
