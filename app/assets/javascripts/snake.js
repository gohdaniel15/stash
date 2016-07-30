$(document).ready(function() {

	scoreCount = 0;
	direction = "down";
	foodCount = 1;
	isSuperfood = false;
	superFoodTimer = 0;
	difficulty = 70;
	sameGame = false;
  play = false;
  dead = false;
  prevPosition = "down";
  foodValue = 10;
  superFoodValue = 100;

  //--------------------------------- Initializing game --------------------------------//

  $('.start-game').click(function() {

    // Creating an array of all the grid positions

    max_left = 0;
    max_top = 0;
    max_right = 435;
    max_bottom = 435;

    gameBoxArr = [];
    left = 0;
    up = 0;

    function GridPosition(left, up) {
        this.left = left;
        this.up = up;
    }

    while (left < 450 && up < 450) {
      var gridPosition = new GridPosition(left, up);
      gameBoxArr.push(gridPosition);
      if (left === 435) {
        left = 0;
        up += 15;
      }
      else {
        left += 15;
      }
    }


    // Randomising food location + snake color

    function randPosition () {
      return String((Math.floor(Math.random()*25)*15))+"px";
    }

    rand_color = ["#c5e1a5", "#ffe082", "#4fc3f7", "#f48fb1", "#ef9a9a", "#ce93d8", "#c5cae9", "#80cbc4", "#ffab91", "#fff59d"][Math.floor(Math.random() * 10)];
    $(".snake").css("background-color", rand_color)
    $('.food').css("background-color", "white");
    $('.food').css("top", randPosition());
    $('.food').css("left", randPosition());


      gameStart = setInterval(move, difficulty);
  })


  //--------------------------------- Head movement logic --------------------------------//

  $(document).keydown(function(key) {
    switch(parseInt(key.which,10)) {
		case 37:
				direction = "left";
			break;
		case 38:
				direction = "up";
			break;
		case 39:
				direction = "right";
			break;
		case 40:
				direction = "down";
			break;
		}
	});


  function move() {

  	lastLeft = $("#snake-head").position().left;
  	lastTop = $("#snake-head").position().top;
  	
  	if (direction === "left") {
  		if ($("#snake-head").position().left <= max_left) {
  			clearInterval(gameStart);
  			$("#food").remove();
  			dead = true;
  			prevPosition = "down";
  		}
  		else if (prevPosition !== "right") {
  			$('#snake-head').css("left", "-=15px");
  			prevPosition = "left";
  		}
  		else {
  			$('#snake-head').css("left", "+=15px");
  		}
  	}

  	else if (direction === "up") {
  		if ($("#snake-head").position().top <= max_top) {
  			clearInterval(gameStart);
  			$("#food").remove();
  			dead = true;
  			prevPosition = "down";
  		}
  		else if (prevPosition !== "down") {
  			$('#snake-head').css("top", "-=15px");
  			prevPosition = "up";
  		}
  		else {
  			$('#snake-head').css("top", "+=15px");
  		}
  	}

  	else if (direction === "right") {
  		if ($("#snake-head").position().left >= max_right) {
  			clearInterval(gameStart);
  			$("#food").remove();
  			dead = true;
  			prevPosition = "down";
  		}
  		else if (prevPosition !== "left") {
  			$('#snake-head').css("left", "+=15px");
  			prevPosition = "right";
  		}
  		else {
  			$('#snake-head').css("left", "-=15px");
  		}
  	}

  	else if (direction === "down") {
  		if ($("#snake-head").position().top >= max_bottom) {
  			clearInterval(gameStart);
  			$("#food").remove();
  			dead = true;
  			prevPosition = "down";
  		}
  		else if (prevPosition !== "up") {
    		$('#snake-head').css("top", "+=15px");
    		prevPosition = "down";
  		}
  		else {
  			$('#snake-head').css("top", "-=15px");
  		}
  	}

    if (isSuperfood) {
      superFoodTimer -= 1;
      $(".super-food-timer").html(superFoodTimer);
    }


    //--------------------------------- Body movement logic --------------------------------//

  	wholeSnake = document.getElementById("game-box").childNodes;

  	snakeArr = [];

  	if (dead === false) {

	  	wholeSnake.forEach( function(body, index) {

	  		if (index != 0 && index != 1) {

	  			snakeArr.push(body.style);

	  			var target = "#snake-body-" + (index - 1);
		  		thisLeft = $(target).position().left;
		  		thisTop = $(target).position().top;
		  		$(target).css("left", lastLeft);
		  		$(target).css("top", lastTop);
		  		lastLeft = thisLeft;
		  		lastTop = thisTop;
		  	}

		  });

	  }


    //--------------------------------- Check if snake crashed into itself --------------------------------//

	  snakeArr.forEach( function(body) {
	  	if ((body.top === $("#snake-head").position().top + "px") && (body.left === $("#snake-head").position().left + "px") ) {
	  		clearInterval(gameStart);
	  		$("#food").remove();
	  	}
	  });


    //--------------------------------- Food and growing logic --------------------------------//

	  if (($("#snake-head").position().left === $(".food").position().left) && ($("#snake-head").position().top === $(".food").position().top)) {
	  	if (isSuperfood) {
	  		scoreCount += superFoodTimer;
	  		foodCount += 1;
	  		isSuperfood = false;
	  		$('.food').toggleClass("superfood");
        $('.super-food-timer').html(100);
	  		$('.super-food-timer').hide();
	  	}
	  	else {
  	  	scoreCount += foodValue;
  	  	foodCount += 1;
	  	}

	  	newTail = "snake-body-" + (document.getElementById("game-box").childNodes.length - 1);
  		diffSynNewTail = "#" + newTail;

	  	$(".score-count").html(scoreCount);
	  	$("#game-box").append("<div class=" + "snake " + "id=" + newTail + ">" + "</div>");
	  	$(diffSynNewTail).css("left", lastLeft);
	  	$(diffSynNewTail).css("top", lastTop);
	  	$(".snake").css("background-color", rand_color)


      // Respawning food in valid locations

	  	allValidFoodLocation = gameBoxArr;

	  	snakeArr.forEach ( function(body) {
	  		allValidFoodLocation = allValidFoodLocation.filter( function(value) {
	  			return !(((value.up + "px") === body.top) && ((value.left + "px") === body.left));
	  		});
	  	});


	  	var randPos = allValidFoodLocation[Math.floor((Math.random()*allValidFoodLocation.length))]

	  		$('.food').css("top", randPos.up );
	  		$('.food').css("left", randPos.left );


      // Superfood logic

	  	if (foodCount%10 === 0) {
	  		isSuperfood = true;
	  		superFoodTimer = superFoodValue;
	  		$('.food').toggleClass("superfood");
	  		$('.super-food-timer').show();
	  	}

	  }

  }


  //--------------------------------- Restart game --------------------------------//

  $('.restart-game').click(function() {
  	clearInterval(gameStart);
  	play = false;
  	scoreCount = 0;
  	$(".score-count").html(scoreCount);
  	$("#game-box").remove();
  	$(".wrapper").append("<div id=" + "game-box" + ">" + "</div>");
  	$("#game-box").append("<div class=" + "food" + ">" + "</div>");
  	$("#game-box").append("<div class=" + "snake " + "id=" + "snake-head" + ">" + "</div>");
  	$("#game-box").append("<div class=" + "snake " + "id=" + "snake-body-1" + ">" + "</div>");
  	$("#game-box").append("<div class=" + "snake " + "id=" + "snake-body-2" + ">" + "</div>");
  	$('.super-food-timer').hide();
	  foodCount = 1;
	  dead = false;
    direction = "down";
    if (isSuperFood) {
      $('.food').toggleClass("superfood");
      $('.super-food-timer').hide();
      $('.super-food-timer').html(100);
    }

  })

  



});