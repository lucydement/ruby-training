$(function() {
  var gameId = $("meta[property=game_id]").attr("content");

  var displayTile = function(div, x, y) {
    div.css({left: x * 52 - 18, top: y * 70 - 27, position: 'absolute'});
  };

  var placeTile = function(tile, x, y, div) {
    tile.x = x;
    tile.y = y;
    displayTile(div, x + 1/2, y + 1/2);
  }

  var processGameData = function(game_tiles) {
    var CurrentUserId = parseInt($("meta[property=current_user_id]").attr("content"));
    console.log("data:", game_tiles);
    console.log(CurrentUserId);
    var tiles = game_tiles.tiles;
    var board = $("#board").empty();

    tiles.forEach(function(tile) {
      if(tile.player_id == CurrentUserId || tile.on_board) {
        var wrapperDiv = $("<div>")
          .addClass("wrapper");

        var div = $("<div>")
          .addClass("tile")
          .addClass(tile.colour)
          .data("tile-id", tile.id)
          .text(tile.number)
          .appendTo(wrapperDiv);

        var shadowDiv = $("<div>")
          .addClass("shadow")
          .appendTo(wrapperDiv);

        if (tile.player_id) {
          $("#hand").append(wrapperDiv);
        }
        else {
          $("#board").append(wrapperDiv);
          displayTile(wrapperDiv, tile.x + 1/2, tile.y + 1/2);
        }
      }
    });

    $(".wrapper").on('mousedown', function(e){
      var moving_div = $(this);
      var tile = moving_div.find(".tile");
      var tileId = tile.data("tileId");

      var moving_tile = _.find(tiles,function(tile){
          return tile.id == tileId;
        });

      var handlers = {
        mousemove : function(e) {
          displayTile(moving_div, e.pageX / 52.0, e.pageY / 70.0);
          moving_div.css("z-index", 9999);
        },
        mouseup : function(e) {
          moving_div.css("z-index", 'auto');
          var adjustX = Math.floor(e.pageX / 52.0);
          var adjustY = Math.floor(e.pageY / 70.0);
          coordinates = findNearestSpace(adjustX, adjustY, tileId, tiles);
          console.log(coordinates);
          placeTile(moving_tile, coordinates[0], coordinates[1], moving_div);
          $(this).off(handlers);
        }
      }
      $(document).on(handlers);
    });

    $("#submit").click( function() {
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

    $("#drawTile").click( function() {
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

    $("#reset").click( function(){
      console.log("Reset");
      location.reload();
    });
  };

  $.getJSON("/games/" + gameId).done(processGameData);
});