class PeopleBuying
  def calculate(people_walking_by, price)
    if price != 0
      (people_walking_by * (50 / price)).to_i
    else
      people_walking_by
    end
  end
end