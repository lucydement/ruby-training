var placeTile = function(tile, tileId, x, y, div, player_id, tiles) {
	div.css("z-index", 'auto');

  if(notOnBoard(x, y) && div.attr("class").indexOf("inHand") != -1){
  	placeTileInHand(tile, div, player_id);
  } else {
  	coordinates = findNearestSpace(x, y, tileId, tiles);
  	placeTileOnBoard(tile, coordinates[0], coordinates[1], div);
  }
}

var placeTileOnBoard = function(tile, x, y, div) {
	tile.x = x;
  tile.y = y;
  tile.player_id = null;
  tile.on_board = true;
  displayTile(div, x + 1/2, y + 1/2);
}

var placeTileInHand = function(tile, div, player_id) {
  tile.x = null;
  tile.y = null;
  tile.player_id = player_id;
  tile.on_board = false;
  div.css({left: 'auto' , top: 'auto', position: 'relative'});
}

var displayTile = function(div, x, y) {
	div.css({left: x * 52 - 18, top: y * 70 + 15, position: 'absolute'});
}

var notOnBoard = function(x, y) {
	var boardWidth = parseInt($("meta[property=board_width]").attr("content"));
	var boardHeight = parseInt($("meta[property=board_height]").attr("content"));

  return (x < 0 || y < 0 || x >= boardWidth || y >= boardHeight);
}