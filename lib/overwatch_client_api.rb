class OverwatchClientApi  
  #endpoints can go into a config or env variable
  HERO_ENDPOINT = 'https://overwatch-api.net/api/v1/hero'
  ABILITY_ENDPOINT = 'https://overwatch-api.net/api/v1/ability'

  # @id integer the hero id
  # @save boolean save the fetched data
  def self.get_hero(id, save = nil)  
    uri = URI("#{HERO_ENDPOINT}/#{id}")
    res = Net::HTTP.get_response(uri)
    hero_fields = hero_fields(JSON.parse(res.body))
    save ? persist_hero_data(hero_fields):hero_fields
  end

  private 
  # this should go in another class, I am putting it here due to time
  # I know I am scanning the json 5 times, this can improve
  def self.hero_fields(json_response)
    {
      name: json_response.dig('name'),
      real_name: json_response.dig('real_name'),
      health: json_response.dig('health'),
      armour: json_response.dig('armour'),
      shield: json_response.dig('shield'),
    }
  end

  # this method sholdn't be here either
  def self.persist_hero_data(hero_data)
    hero = Hero.find_by_name(hero_data[:name])
    Hero.create!(hero_data) unless hero.present?
  rescue => e 
    # some log
    puts e.message
  end
end

