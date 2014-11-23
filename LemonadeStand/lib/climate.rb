class Climate
  MAX_TEMP = 40
  MIN_TEMP = -10

  def initialize(previous_temp:)
    @previous_temperature = previous_temp
  end

  def generate_temp
    @previous_temperature = rand(@previous_temperature - 5..@previous_temperature + 5)
    if @previous_temperature > MAX_TEMP
      @previous_temperature = MAX_TEMP
    end
    if @previous_temperature < MIN_TEMP
      @previous_temperature = MIN_TEMP
    end
    @previous_temperature
  end  
end