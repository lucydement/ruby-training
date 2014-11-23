class Population
  POPULATION = 100

  def number_of_people_walking_by(temp:)
    people_walking_by = POPULATION * generate_proportion(temp: temp) + rand(-5..5)
    if people_walking_by < 0
      0
    else
      people_walking_by.to_i
    end
  end

  def generate_proportion(temp:)
    1000 * (temp - Climate::MIN_TEMP) / Climate::MAX_TEMP 
  end
end