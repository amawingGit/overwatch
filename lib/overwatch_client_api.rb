class OverwatchClientApi  
  #endpoints can go into a config or env variable
  HERO_ENDPOINT = 'https://overwatch-api.net/api/v1/hero'
  ABILITY_ENDPOINT = 'https://overwatch-api.net/api/v1/ability'

  def initialize
  end

  # @id integer the hero id
  # @save boolean save the fetched data
  def self.get_hero(id)  
    uri = URI("#{HERO_ENDPOINT}/#{id}")
    res = Net::HTTP.get_response(uri)
    JSON.parse(res.body)
  end


  # @id integer the hero id
  # @save boolean save the fetched data
  def self.get_ability(id)
    uri = URI("#{ABILITY_ENDPOINT}/#{id}")
    res = Net::HTTP.get_response(uri)
    JSON.parse(res.body)
  end
end

