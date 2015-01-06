$(function() {
  var gameId = $("meta[property=game_id]").attr("content");
  var boardWidth = parseInt($("meta[property=board_width]").attr("content"));
  var boardHeight = parseInt($("meta[property=board_height]").attr("content"));
  var activePlayerNumber;

  var setActivePlayerNumber = function(number) {
    activePlayerNumber = number;
  };

  var displayTile = function(div, x, y) {
    div.css({left: x * 52 - 18, top: y * 70 + 15, position: 'absolute'});
  };

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

  var notOnBoard = function(x, y) {
    return (x < 0 || y < 0 || x >= boardWidth || y >= boardHeight);
  }

  var processGameData = function(tiles) {
    var currentPlayerId = parseInt($("meta[property=current_player_id]").attr("content"));
    var activePlayerId = parseInt($("meta[property=active_player_id").attr("content"));

    // if(currentPlayerId == activePlayerId){
    //   Notification.requestPermission()
    //   new Notification("Rummikub", {"body": "Your turn" });
    // } 

    tiles.forEach(function(tile) {
      if(tile.player_id == currentPlayerId || tile.on_board) {
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
          wrapperDiv.addClass("inHand");
          $("#hand").append(wrapperDiv);
        }
        else {
          $("#board").append(wrapperDiv);
          placeTileOnBoard(tile, tile.x, tile.y, wrapperDiv);
        }
      }
    });

    $(".wrapper").on('mousedown', function(e){
      var movingDiv = $(this);
      var tile = movingDiv.find(".tile");
      var tileId = tile.data("tileId");

      var movingTile = _.find(tiles,function(tile){
          return tile.id == tileId;
        });

      var handlers = {
        mousemove : function(e) {
          displayTile(movingDiv, e.pageX / 52.0, (e.pageY - 50) / 70.0);
          movingDiv.css("z-index", 9999);
        },
        mouseup : function(e) {
          var adjustX = Math.floor(e.pageX / 52.0);
          var adjustY = Math.floor((e.pageY - 50) / 70.0);

          placeTile(movingTile, tileId, adjustX, adjustY, movingDiv, currentPlayerId, tiles);

          $(this).off(handlers);
        }
      }
      $(document).on(handlers);
    });

    $("#submit").click( function() {
      $.ajax({
        type: 'PUT',
        url: '/games/' + gameId,
        contentType: 'application/json',
        data: JSON.stringify({"tiles" : tiles}), 
        success: function(){
          location.reload();
        },
        failure: function(){
          console.log("Failure");
        }
      });
    })

    $("#drawTile").click( function() {
      $.ajax({
        type: 'PUT',
        url: '/games/' + gameId,
        contentType: 'application/json',
        data: JSON.stringify({'tiles': "drawTile"}),
        success: function(){
          location.reload();
        },
        failure: function(){
          console.log("Failure");
        }
      });
    });

    $("#reset").click( function(){
      location.reload();
    });

    setInterval(function(retry){
      function reloadPageIfActivePlayerHasChanged (newPlayerNumber) {
        if(activePlayerNumber != newPlayerNumber){
          location.reload();
        }
      };

      $.getJSON("/games/" + gameId + "/active_player_number").done(reloadPageIfActivePlayerHasChanged);
    }, 2000);
  };

  $.getJSON("/games/" + gameId).done(processGameData);
  $.getJSON("/games/" + gameId + "/active_player_number").done(setActivePlayerNumber);
});