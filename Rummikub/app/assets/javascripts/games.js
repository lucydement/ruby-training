$(function() {
  var gameId = $("meta[property=game_id]").attr("content");
  var boardWidth = parseInt($("meta[property=board_width]").attr("content"));
  var boardHeight = parseInt($("meta[property=board_height]").attr("content"));
  var currentPlayerNumber;

  var setCurrentPlayerNumber = function(number) {
    currentPlayerNumber = number;
    console.log("currentPlayerNumber " + number);
  };

  var displayTile = function(div, x, y) {
    div.css({left: x * 52 - 18, top: y * 70 + 15, position: 'absolute'});
  };

  var placeTile = function(tile, x, y, div) {
    tile.x = x;
    tile.y = y;
    displayTile(div, x + 1/2, y + 1/2);
  }

  var notOnBoard = function(x, y) {
    console.log("x < 0: " + (x<0));
    console.log("y < 0: " + (y<0));
    console.log("x >= boardWidth: " + (x >= boardWidth));
    console.log("y >= boardHeight: " + (y >= boardHeight));
    console.log(x < 0 || y < 0 || x >= boardWidth || y >= boardHeight);
    return (x < 0 || y < 0 || x >= boardWidth || y >= boardHeight);
  }

  var processGameData = function(game_tiles) {
    var CurrentUserId = parseInt($("meta[property=current_user_id]").attr("content"));
    var CurrentPlayerId = parseInt($("meta[property=current_player_id").attr("content"));
    
    if(CurrentUserId == CurrentPlayerId){
      Notification.requestPermission()
      new Notification("Rummikub", {"body": "Your turn" });
    } 

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
          displayTile(moving_div, e.pageX / 52.0, (e.pageY - 50) / 70.0);
          moving_div.css("z-index", 9999);
        },
        mouseup : function(e) {
          moving_div.css("z-index", 'auto');
          var adjustX = Math.floor(e.pageX / 52.0);
          var adjustY = Math.floor((e.pageY - 50) / 70.0);
          console.log(adjustX);
          console.log(adjustY);
          console.log(moving_tile);
          if(notOnBoard(adjustX, adjustY) && moving_tile.player_id != null){
            console.log("in hand");
            moving_tile.x = null;
            moving_tile.y = null;
            moving_div.css({left: 'auto' , top: 'auto', position: 'relative'});
          } else {
            console.log("on board");
            coordinates = findNearestSpace(adjustX, adjustY, tileId, tiles);
            console.log(coordinates);
            placeTile(moving_tile, coordinates[0], coordinates[1], moving_div);
          }
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

    setInterval(function(retry){
      console.log("poll");

      function reloadPageIfCurrentPlayerHasChanged (newPlayerNumber) {
        if(currentPlayerNumber != newPlayerNumber){
          location.reload();
        }
      };

      $.getJSON("/games/" + gameId + "/current_player_number").done(reloadPageIfCurrentPlayerHasChanged);
    }, 2000);
  };

  $.getJSON("/games/" + gameId).done(processGameData);
  $.getJSON("/games/" + gameId + "/current_player_number").done(setCurrentPlayerNumber);
});