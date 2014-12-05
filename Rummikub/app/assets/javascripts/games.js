$(function() {
  var gameId = $("meta[property=game_id]").attr("content");

  var positionTile = function(div, x, y) {
    div.css({left: x * 52 - 18, top: y * 70 - 27, position: 'absolute'});
  };

  var onBoard = function(x,y) {
    if(x < 0 || x > 15) return false;
    if(y < 0 || y > 7) return false;
    return true;
  }

  var notOnTile = function(x, y, tileId, tiles) {
    tile_with_coordinates = _.filter(tiles, function(tile) {
      return tile.x == x && tile.y == y && tile.id != tileId;
    });
    console.log(tile_with_coordinates.length);
    if(tile_with_coordinates.length > 0) return false;
    return true;
  }

  var processGameData = function(game_tiles) {
    console.log("data:", game_tiles);
    var tiles = game_tiles.tiles;
    var board = $("#board").empty();

    tiles.forEach(function(tile) {
      var div = $("<div>")
        .addClass("tile")
        .addClass(tile.colour)
        .data("tile-id", tile.id)
        .text(tile.number);

      if (tile.player_id) {
        $("#hand").append(div);
      }
      else {
        $("#board").append(div);
        positionTile(div, tile.x + 1/2, tile.y + 1/2);
      }
    });

    $(".tile").on('mousedown', function(e){
      var moving_div = $(this)
      var tileId = $(this).data("tileId");
      var moving_tile = _.find(tiles,function(tile){
          return tile.id == tileId;
        });
      var handlers = {
        mousemove : function(e) {
          positionTile(moving_div,e.pageX/52.0,e.pageY/70.0);
          moving_div.css("z-index", 9999);
        },
        mouseup : function(e) {
          moving_div.css("z-index", 0);
          var adjustX = Math.floor(e.pageX/52.0);
          var adjustY = Math.floor(e.pageY/70.0);
          if (onBoard(adjustX, adjustY) && notOnTile(adjustX,adjustY,tileId,tiles)){
            moving_tile.x = adjustX;
            moving_tile.y = adjustY;
            positionTile(moving_div,adjustX + 1/2,adjustY + 1/2);
          }else{
            positionTile(moving_div, moving_tile.x + 1/2, moving_tile.y + 1/2);
          }
          $(this).off(handlers)
        }
      }
      $(document).on(handlers);
    });

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
          location.reload();
        },
        failure: function(){
          console.log("Failure");
        }
      });
    })

    $("#drawTile").click(function() {
      console.log("Draw Tile");
      console.log(JSON.stringify({'drawTile': "drawTile"}))
      $.ajax({
        type: 'PUT',
        url: '/games/' + gameId,
        contentType: 'application/json',
        data: JSON.stringify({'drawTile': "drawTile"}),
        success: function(){
          console.log("Success");
          location.reload();
        },
        failure: function(){
          console.log("Failure");
        }
      });
    });

    $("#reset").click(function(){
      console.log("Reset");
      location.reload();
    });
  };

  $.getJSON("/games/" + gameId).done(processGameData);
});