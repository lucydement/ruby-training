module ImageHelper
  def display_image(game)
    html = "<svg width=\"100\" height=\"100\">"
    if game.number_lives_left <= 8
      html << line(10, 90, 90, 90)
    end
    if game.number_lives_left <= 7
      html << line(10, 90, 10, 10)
    end
    if game.number_lives_left <= 6
      html << line(10, 70, 30, 90)
    end
    if game.number_lives_left <= 5
      html << line(10, 10, 80, 10)
      html << line(80,10,80,20)
    end
    if game.number_lives_left <= 4
      html << line(10, 30, 30, 10)
    end
    if game.won?
      html << display_won
      html << "</svg>"
      return html.html_safe
    end
    if game.number_lives_left <= 3
      html << "<circle cx=\"80\" cy=\"30\" r=\"10\" stroke=\"rgb(255,0,0)\" stroke-width=\"2\" fill= \"none\" />" 
    end
    if game.number_lives_left <= 2
      html << line(80, 40, 80, 60)
    end
    if game.number_lives_left <= 1
      html << line(80, 60, 70, 80)
      html << line(80, 60, 90, 80)
    end
    if game.lost?
      html << line(80, 48, 70, 55)
      html << line(80, 48, 90, 55)
    end
    html << "</svg>"
    html.html_safe
  end

  def display_won
    html = "<circle cx=\"80\" cy=\"40\" r=\"10\" stroke=\"rgb(255,0,0)\" stroke-width=\"2\" fill= \"none\" />" 
    html << line(80, 50, 80, 70)
    html << line(80, 70, 70, 90)
    html << line(80, 70, 90, 90)
    html << line(80, 58, 70, 55)
    html << line(80, 58, 90, 55)
  end

  def line(x1, y1, x2, y2)
    "<line x1=\"#{x1}\" y1=\"#{y1}\" x2=\"#{x2}\" y2=\"#{y2}\" style=\"stroke:rgb(255,0,0);stroke-width:2\" />"
  end
end