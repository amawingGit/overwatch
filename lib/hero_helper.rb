class HeroHelper

  def self.capture_hero_detail(ucid)
    hero_details = get_hero_details(ucid)
    hero_record = Hero.find_by_ucid(hero_details[:ucid])
  
    if hero_record.present?
      p "hero #{hero_record[:name]} already in database"
    else
      Hero.create(get_hero_details(ucid))
      p "hero #{hero_record[:name]} saved successful"
    end
  rescue => e
    puts e.message
  end

  def self.get_hero_details(ucid)
    response = OverwatchClientApi.get_hero(ucid)
    hero_fields(response)
  end

  private

  def self.hero_fields(json_response)
    {
      name: json_response.dig('name'),
      real_name: json_response.dig('real_name'),
      ucid: json_response.dig('id'),
      health: json_response.dig('health'),
      armour: json_response.dig('armour'),
      shield: json_response.dig('shield'),
    }
  end
end