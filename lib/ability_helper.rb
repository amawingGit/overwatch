class AbilityHelper

   def self.capture_ability_detail(ucid)
    ability_details = get_ability_details(ucid)
    ability_record = Ability.find_by_ucid(ability_details[:ucid])
  
    if ability_record.present?
      p "ability #{ability_record[:name]} already in database"
    else
      Ability.create(get_ability_details(ucid))
      p "ability #{ability_record[:name]} saved successful"
    end
  rescue => e
    puts e.message
  end

  def self.get_ability_details(ucid)
    response = OverwatchClientApi.get_ability(ucid)
    ability_fields(response)
  end

  private

  def self.ability_fields(json_response)
    {
      name: json_response.dig('name'),
      description: json_response.dig('description'),
      is_ultimate: json_response.dig('is_ultimate'),
      ucid: json_response.dig('id'),
      hero_id: json_response.dig('hero','id')
    }
  end

end