$(document).ready(function () {
	$('.play-snake').click(function () {
		$('.snake-container').show();
		$('.snake-container-overlay').show();

	})

	$('.snake-container-overlay').click(function () {
		$('.snake-container').hide();
		$('.snake-container-overlay').hide();
	})


});