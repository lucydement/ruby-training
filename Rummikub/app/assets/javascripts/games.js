$(document).ready(function() {
	$("ol.set").sortable().disableSelction;
	$(".set").sortable({
		connectWith: ".set"
	});

	$("#new_set").droppable({
		hoverClass : 'ui-state-highlight',
		drop: function(event, ui) {
			console.log("Dropped");
			console.log(ui.draggable.attr("class"));
		}
	});
});

