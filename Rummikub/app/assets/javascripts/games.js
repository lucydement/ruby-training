$(function() {
  var gameId = $("meta[property=game_id]").attr("content");

  var displayTile = function(div, x, y) {
    div.css({left: x * 52 - 18, top: y * 70 - 27, position: 'absolute'});
  };

  var placeTile = function(tile, x, y, div) {
    tile.x = x;
    tile.y = y;
    displayTile(div,x + 1/2,y + 1/2);
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
        displayTile(div, tile.x + 1/2, tile.y + 1/2);
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
          displayTile(moving_div,e.pageX/52.0,e.pageY/70.0);
          moving_div.css("z-index", 9999);
        },
        mouseup : function(e) {
          moving_div.css("z-index", 0);
          var adjustX = Math.floor(e.pageX/52.0);
          var adjustY = Math.floor(e.pageY/70.0);
          coordinates = findNearestSpace(adjustX, adjustY, moving_tile.id, tiles);
          placeTile(moving_tile, coordinates[0], coordinates[1], moving_div);
          $(this).off(handlers);
        }
      }
      $(document).on(handlers);
    });

    $("#submit").click(function() {
      console.log("Submit");
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
      $.ajax({
        type: 'PUT',
        url: '/games/' + gameId,
        contentType: 'application/json',
        data: JSON.stringify({'tiles': "drawTile"}),
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