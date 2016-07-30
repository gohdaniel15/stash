$(document).ready(function () {
	$('.play-snake').click(function () {
		$('.snake-container').show();
		$('.snake-container-overlay').show();

	})

	$('.snake-container-overlay').click(function () {
		$('.snake-container').hide();
		$('.snake-container-overlay').hide();
	})


	function fetchArticles() {
		more_posts_url = "/articles/fetch"
		$.getScript(more_posts_url)
	}

	gameStart = setInterval(fetchArticles, 600000);

});