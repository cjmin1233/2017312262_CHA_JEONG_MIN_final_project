$(document).ready(function() {
	// fixed frame rate
	const fps = 120;

	var canvas = document.getElementById("canvas");
	if(canvas.getContext){
		var ctx=canvas.getContext('2d');
	}
	var timer = 0;
	var enemy_container = [];
	/* vertical movement */
	var isJumping = false;
	const base_velocity_y = 12;
	var current_velocity_y = base_velocity_y;
	const gravity = 0.6;

	var animation;	// animation frame
	var isPaused = true;
	var isStarted = false;
	var topScore = 0;
	var score = 0;
	const base_game_speed = 5;
	var current_game_speed = base_game_speed;
	var bgImagePos;
	var backgroundImage=document.getElementById("backgroundImage");
	
	/* player and enemy image animator */
	const player_animator=document.querySelectorAll(".playerImage");
	const golem_animator=document.querySelectorAll(".golemImage");
	const slime_animator=document.querySelectorAll(".slimeImage");
	const bat_animator=document.querySelectorAll(".batImage");
	
	// Audio Resource initialization
	var jump_audio = new Audio('audio/jump.mp3');
	var die_audio = new Audio('audio/die.mp3');
	var point_audio = new Audio('audio/point.wav');
	point_audio.loop=false;
	point_audio.volume=1.0;
	die_audio.loop=false;
	die_audio.volume=1.0;
	jump_audio.playbackRate=3.5;
	jump_audio.loop=false;
	jump_audio.volume=1.0;

	// Audio play functions
	function playJumpAudio(){
		jump_audio.play();
	}
	function playDieAudio(){
		die_audio.play();
	}
	function playPointAudio(){
		point_audio.play();
	}
	/////////////////////////////////
	// get best user score from the jsp
	topScore= document.getElementById('topScore').innerHTML;

	canvas.width = 950;
	canvas.height = 450;
	bgImagePos=canvas.width;
	ctx.font = "20px Arial";
	
	// player initail position
	var start_player_pos_x=90;
	var start_player_pos_y=400;
	var img_offsest_x=10;	// player image offset
	// enemy spawn position
	var start_enemy_pos_x=900;
	var start_enemy_pos_y=400;
	

	// player object
	var player = {
		x: start_player_pos_x,
		y: start_player_pos_y,
		width: 50,
		height: 50,
		ani_frame: 0,
		draw() {
			// draw the player image
			ctx.drawImage(player_animator[this.ani_frame], this.x+this.width-player_animator[this.ani_frame].width*0.5+img_offsest_x, this.y+this.height-player_animator[this.ani_frame].height*0.5, player_animator[this.ani_frame].width*0.5, player_animator[this.ani_frame].height*0.5);
		},
		init() {
			// player initialization
			this.x = start_player_pos_x;
			this.y = start_player_pos_y;
			isJumping = false;
			score = 0;
			current_velocity_y = base_velocity_y;
			current_game_speed = base_game_speed;
			this.ani_frame=0;
		}
	}
	class Enemy {
		constructor() {
			this.x = start_enemy_pos_x;
			this.y = start_enemy_pos_y;
			this.width = 50;
			this.height = 50;
			this.ani_frame = 0;
			// there are three type enemy::golem, slime, bat
			this.type = Math.floor(Math.random() * 3);
			// adjust the postion to the corresponding type
			if(this.type==1) this.y+=20;
			else if(this.type==2){
				this.y*=0.8;
				this.height-=20;
			}				
		}
		draw() {
			// draw the enemy image
			if(this.type==0)ctx.drawImage(golem_animator[this.ani_frame], this.x-this.width, this.y-this.height*1.2, this.width*3, this.height*3);
			else if(this.type==1)ctx.drawImage(slime_animator[this.ani_frame], this.x-this.width, this.y-this.height*1.2-20, this.width*3, this.height*3);
			else ctx.drawImage(bat_animator[this.ani_frame], this.x-this.width, this.y-this.height*1.2-25, this.width*3, this.width*3);
		}
	}
	function Start(){
		// show the start window
		ctx.clearRect(0, 0, canvas.width, canvas.height);
		ctx.fillStyle = 'black';
		ctx.textAlign = "center";
		ctx.fillText("PRESS SPACE TO START", canvas.width*0.5, canvas.height*0.5);
		player.draw();
		$('.result-score').hide();
		$('.update-score-box').hide();
	}
	function Result(){
		// if player died or game over, show the result section
		isPaused = true;
		setTimeout(function() {
			// wait 2s before start
			isStarted = false;
		}, 2000);
		$('#current-score').html("Score : "+score);
		// if score is higher than best score, update it
		if(score>topScore) topScore=score;
		$('#highest-score').html("Best score : "+topScore);
		$('.result-score').fadeIn();
		$('.update-score-box').fadeIn();
		ctx.fillStyle = 'white';
		ctx.textAlign = "center";
		ctx.fillText("G A M E   O V E R", canvas.width*0.5, canvas.height*0.3);
		ctx.fillText("PRESS SPACE TO RESTART", canvas.width*0.5, canvas.height*0.5);
		ctx.fillText("↓↓ UPDATE YOUR SCORE ↓↓", canvas.width*0.5, canvas.height*0.8);
	}
	function Restart(){
		// restart the game
		isPaused=false;
		isStarted=true;
		// delete all remain enemy
		enemy_container.splice(0, enemy_container.length);
		// player initialization
		player.init();
		$('#current-score').html("");
		$('#highest-score').html("");
		$('.result-score').hide();
		$('.update-score-box').hide();
		// start frame
		updateFrame();
	}
	
	function updateFrame() {
		if (isPaused) cancelAnimationFrame(animation);
		else {
			setTimeout(() => {
				animation = requestAnimationFrame(updateFrame);
			}, 1000 / fps);
			timer++;
			ctx.clearRect(0, 0, canvas.width, canvas.height);	// clear the previous canvas frame 
			/* draw 3 background image to make moving background */
			ctx.drawImage(backgroundImage, bgImagePos-canvas.width, 0, canvas.width, canvas.height);
			ctx.drawImage(backgroundImage, bgImagePos, 0, canvas.width, canvas.height);
			ctx.drawImage(backgroundImage, bgImagePos+canvas.width, 0, canvas.width, canvas.height);
			bgImagePos--;
			if(bgImagePos<=0)bgImagePos+=canvas.width;
			
			// draw the score text to the top right side of the canvas
			ctx.fillStyle = 'white';
			ctx.fillText("Score : " + (++score).toString(), canvas.width - 200, 50);
			if (score % 1000 === 0) {
				// the game speed increase every 1000 score points
				current_game_speed++;
				playPointAudio();
			}
			if (timer % fps === 0) {
				// enemy spawn and push to the enemy container
				var enemy = new Enemy();
				enemy_container.push(enemy);
			}
			if(timer % (fps/12) === 0){
				// aniamte the player image
				player.ani_frame=(player.ani_frame+1) % 4;
			}
			
			/* enemy updating function */
			enemy_container.forEach((enemy, index, array) => {
				// update each enemy info from the container
				enemy.x -= current_game_speed;	// move enemy to the left
				if(timer % (fps/12)===0)enemy.ani_frame=(enemy.ani_frame+1)%4;	// animate the enemy image
				if (enemy.x + enemy.width < 0) {
					// if enemy went to the left most side, remove the enemy from the array
					array.splice(index, 1);
				}
				// draw the enemy image
				enemy.draw();
			});
			
			/* player jump function */
			if (isJumping) {
				current_velocity_y -= gravity;
				player.y -= current_velocity_y;
				if (player.y >= start_player_pos_y) {
					player.y = start_player_pos_y;
					isJumping = false;
					current_velocity_y = base_velocity_y;
				}
			}
			
			// drawy the player image
			player.draw();
			
			/* collision check function between player and all enemy */
			enemy_container.forEach((enemy, index, array) => {
				if(isPaused)return false;	// if game paused break the loop
				if((enemy.x>player.x-enemy.width) && (enemy.x<player.x+player.width)){
					if((enemy.y>player.y-enemy.height)&&(enemy.y<player.y+player.height)){
						// Collision occur, play the die sound and show result
						if(!isPaused){
							playDieAudio();
							Result();
						}
						
					}
				}
			});
		}
		
	}
	
	/* main */
	Start();
	/* main */

	document.addEventListener('keydown', function(e) {
		// input controller
		if (e.code === 'Space') {
			if(!isJumping){
				// if player is not jumping, jump action occur
				isJumping = true;
				if(!isPaused)playJumpAudio();
			}
			if(isPaused && !isStarted){
				// if game over
				Restart();
			}
			e.preventDefault();
		}
		if (e.code === 'KeyE' && !isPaused) {
			// you can pause game by pressing 'e'
			Result();
		}
		if (e.code === 'KeyR' && isPaused) {
			// you can restart game by pressing 'r'			
			Restart();
		}
	});
	$('#updateScoreButton').click(function(){
		// if update score button clicked, transfer the best score to jsp file
		location.href='updateScore.jsp?userScore='+topScore.toString();
	});
});
