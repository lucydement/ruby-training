$(function() {
  var gameId = $("meta[property=game_id]").attr("content");
  var activePlayerNumber;

  var setActivePlayerNumber = function(number) {
    activePlayerNumber = number;
  };

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
      console.log("poll");
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