var findNearestSpace = function(x, y, tileId, tiles) {
  if (x > 15) x = 15;
  if (x < 0) x = 0;
  if (y > 7) y = 7;
  if (y < 0) y = 0;

  visited = [];
  queue = [];
  queue.push([x,y]);

  while (queue.length > 0) {
    square = queue.shift();
    if(notVisited(square, visited)) {
      visited.push(square);

      if(tilesWithCoordinates(square[0], square[1], tileId, tiles).length == 0) {
        return square;
      }

      if(square[0] + 1 < 16 && notVisited([square[0] + 1, square[1]], visited))
        queue.push([square[0] + 1, square[1]]);
      if(square[0] - 1 >= 0 && notVisited([square[0] - 1, square[1]], visited))
        queue.push([square[0] - 1, square[1]]);
      if(square[1] + 1 < 8 && notVisited([square[0], square[1] + 1], visited))
        queue.push([square[0], square[1] + 1]);
      if(square[1] - 1 >= 0 && notVisited([square[0], square[1] - 1], visited))
        queue.push([square[0], square[1] - 1]);
    }
  }
}

var tilesWithCoordinates = function(x, y, tileId, tiles) {
  return _.filter(tiles, function(tile) {
    return tile.x == x && tile.y == y && tile.id != tileId;
  });
}

var notVisited = function(square, visited) {
  visit = _.find(visited, function(place) {
    return square[0] == place[0] && square[1] == place[1];
  });
  return visit == null;
}