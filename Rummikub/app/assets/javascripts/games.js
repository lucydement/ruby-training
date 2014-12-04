$(function() {
  var gameId = $("meta[property=game_id]").attr("content");

  var positionTile = function(div, x, y) {
    div.css({left: x * 52 - 18, top: y * 70 - 27, position: 'absolute'});
  };

  var processGameData = function(game_tiles) {
    console.log("data:", game_tiles);
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
        positionTile(div, tile.x + 1/2, tile.y + 1/2);
      }
    });

    var moving_tile;
    var mouseDown = false;
    var moving_div;

    $(".tile")
      .mousedown(function() {
        mouseDown = true;
        var tileId = $(this).data("tileId");
        moving_div = $(this);
        moving_tile = _.find(tiles,function(tile){
          return tile.id == tileId;
        });
      })
      .mousemove(function(){
        if (moving_div != null && mouseDown){
          positionTile(moving_div,event.pageX/52.0,event.pageY/70.0);
        }
      })
      .mouseup(function(){
        mouseDown = false;
        var adjustX = Math.floor(event.pageX/52.0);
        var adjustY = Math.floor(event.pageY/70.0);
        moving_tile.x = adjustX;
        moving_tile.y = adjustY;
        positionTile($(this),adjustX + 1/2,adjustY + 1/2);
      })

    $("#submit").click(function() {
      console.log("Submit");
      console.log(game_tiles);
      $.ajax({
        type: 'PUT',
        url: '/games/' + gameId,
        contentType: 'application/json',
        data: JSON.stringify(game_tiles), 
        success: function(){
          console.log("Success");
        },
        failure: function(){
          console.log("Failure");
        }
      });
    })

    $("#drawTile").click(function() {
      console.log("Draw Tile");
    });
  };

  $.getJSON("/games/" + gameId).done(processGameData);
});