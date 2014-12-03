$(function() {
  var gameId = $("meta[property=game_id]").attr("content");

  var positionTile = function(div, x, y) {
    div.css({left: x - 25, top: y - 25, position: 'absolute'});
  };

  var processGameData = function(game_tiles) {
    var tiles = game_tiles.tiles;
    console.log(game_tiles);
    var board = $("#board").empty();

    tiles.forEach(function(tile) {
      var div = $("<div>")
        .addClass("tile")
        .addClass(tile.colour)
        .data("tile-id", tile.id)
        .text(tile.number);

      if (tile.player_id) {
        console.log("hand");
        $("#hand").append(div);
      }
      else {
        console.log("board");
        $("#board").append(div);
        positionTile(div, tile.x, tile.y);
      }
    });

    var moving_tile;
    var mouseDown = false;

    $(".tile")
      .mousedown(function() {
        mouseDown = true;
        var tileId = $(this).data("tileId");
        moving_tile = _.find(tiles,function(tile){
          return tile.id == tileId;
        });
      })
      .mousemove(function(){
        if ($(this) != null && mouseDown){
          positionTile($(this),event.pageX,event.pageY);
        }
      })
      .mouseup(function(){
        mouseDown = false;
        var adjustX = Math.floor(event.pageX/50.0)*50;
        var adjustY = Math.floor(event.pageY/50.0)*50;
        moving_tile.x = adjustX;
        moving_tile.y = adjustY;
        positionTile($(this),adjustX + 25,adjustY + 25);
      })
  };

  $.getJSON("/games/" + gameId).done(processGameData);
});