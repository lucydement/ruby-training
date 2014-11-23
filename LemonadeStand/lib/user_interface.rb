class UserInterface
  def start_game
    puts "Welcome to Lemonade Stand!\n"
  end

  def start_day(temp, price_lemons, price_sugar, money, items)
    puts "It is the beginning of a new day. \nYou have #{items[:lemons]} lemons and #{items[:sugar]} sugar.\n"
    puts "The temperature is #{temp}."
    puts "The price of lemons is #{price_lemons} per lemon."
    puts "The price of sugar is #{price_sugar} per unit"
    puts "Your current Bank balance is #{money}."
  end

  def get_number_of_lemons_to_buy(max)
    puts "How many lemons do you want to buy: "
    amount = gets.chomp.to_i
    while amount < 0 || amount > max
      puts "You cannot buy that amount of lemons.\nHow many lemons do you want to buy:"
      amount = gets.chomp.to_i
    end
    amount
  end

  def get_number_of_sugar_to_buy(max)
    puts "How many units of sugar do you want to buy: "
    amount = gets.chomp.to_i
    while amount < 0 || amount > max
      puts "You cannot buy that amount of sugar.\nHow much sugar do you want to buy:"
      amount = gets.chomp.to_i
    end
    amount
  end

  def get_number_of_cups_to_make(max)
    puts "How many cups of lemonade do you want to make:"
    amount = gets.chomp.to_i
    while amount < 0 || amount > max
      puts "You cannot make that amount of lemonade.\nHow many cups of lemonade do you want to make:"
      amount = gets.chomp.to_i
    end
    amount
  end

  def get_price_of_lemonade
    puts "How much will you charge per cup of lemonade: "
    gets.chomp.to_i
  end

  def end_day(profit)
    puts "It is the end of the day and you made #{profit} cents."
  end
end