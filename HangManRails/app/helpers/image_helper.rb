module ImageHelper
  def hangman_svg(game)
    current_components = components.first(component_count(game)).join
    current_components << image_won if game.won?
    content_tag :svg, current_components.html_safe, width: 100, height: 100
  end

  private

  def component_count(game)
    components = Game::MAX_LIVES - game.number_lives_left
    game.won? ? [components, 5].min : components
  end

  def components
    [
      [line(10, 90, 90, 90)],
      [line(10, 90, 10, 10)],
      [line(10, 70, 30, 90)],
      [line(10, 10, 80, 10), line(80, 10, 80, 20)],
      [line(10, 30, 30, 10)],
      [tag(:circle, cx: 80, cy: 30, r: 10)],
      [line(80, 40, 80, 60)],
      [line(80, 60, 70, 80), line(80, 60, 90, 80)],
      [line(80, 48, 70, 55), line(80, 48, 90, 55)]
    ]
  end

  def image_won
    html = tag :circle, cx: 80, cy: 40, r: 10
    html << line(80, 50, 80, 70)
    html << line(80, 70, 70, 90)
    html << line(80, 70, 90, 90)
    html << line(80, 58, 70, 55)
    html << line(80, 58, 90, 55)
  end

  def line(x1, y1, x2, y2)
    tag :line, x1: x1, y1: y1, x2: x2, y2: y2
  end
end