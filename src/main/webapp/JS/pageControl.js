$(document).ready(function() {
	// Prevent submit by enter input
	$('input[type="text"]').keydown(function(event) {
		if (event.keyCode === 13) {
			event.preventDefault();
		}
	});

	/* Signup, Login page */
	var nameCheck = false;
	var emailCheck = false;
	var idCheck = false;
	var passwordCheck = false;
	var confirmCheck = false;

	var NameInput;
	var emailInput;
	var idInput;
	var passwordInput;
	var confirmInput;
	///////////////////////////////
	// SignupPage input checking functions, similar with assignment 4
	function NameCheck() {
		nameCheck = true;
		NameInput = $('#userName').val();

		if (NameInput.length == 0) {
			// No input
			$('#nameError').html("Please enter your name!");
			$('#nameError').removeClass("hidden");
			nameCheck = false;
		}
		else {
			for (var i = 0; i < NameInput.length; i++) {
				// Special character or number
				if (!(('a' <= NameInput[i] && NameInput[i] <= 'z') || ('A' <= NameInput[i] && NameInput[i] <= 'Z'))) {
					$('#nameError').html("User name cannot contain special characters or numbers!");
					$('#nameError').removeClass("hidden");

					nameCheck = false;
					break;
				}
			}

		}
		if (NameInput.length > 20) {
			// Name input length exceeds 20
			$('#nameError').html("Name cannot exceeds 20 characters!");
			$('#nameError').removeClass("hidden");
			nameCheck = false;
		}

		if (nameCheck) {
			// OK
			$('#nameError').addClass("hidden");
			$('#nameCheckIcon').css('color', 'green');
			$('#userName').css('border-color', 'white');
		}
		else {
			// wrong input
			$('#userName').css('border-color', 'red');
			$('#nameError').removeClass("hidden");
			$('#nameCheckIcon').css('color', 'rgba(1,1,1,0)');
		}


	}
	function EmailCheck() {
		emailCheck = true;
		// email regular expression
		var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*[.][a-zA-Z]{2,3}$/i;
		emailInput = $('#userEmail').val();

		if (!emailRule.test(emailInput)) {
			// invalid email address
			$('#emailError').html("Your email address is invalid!");
			$('#emailError').removeClass("hidden");

			$('#userEmail').css('border-color', 'red');
			$('#emailCheckIcon').css('color', 'rgba(1,1,1,0)');

			emailCheck = false;
		}
		if (emailInput.length == 0) {
			// No input
			$('#emailError').html("Please enter your email!");
			$('#emailError').removeClass("hidden");

		}
		if (emailCheck) {
			// OK
			$('#emailError').addClass("hidden");
			$('#emailCheckIcon').css('color', 'green');
			$('#userEmail').css('border-color', 'white');
		}
	}
	function IdCheck() {
		idCheck = true;
		// id regular expression
		var idRule = /^([-_]?[0-9a-zA-Z])*$/i;
		idInput = $('#userID').val();

		if (!idRule.test(idInput)) {
			// invalid user id
			$('#idError').html("Your ID can contain special characters ('-', '_'), English, and numbers and cannot end with special characters");
			idCheck = false;
		}

		if (idInput.length == 0) {
			// No input
			$('#idError').html("Please enter your ID!");

			idCheck = false;
		}
		if (idInput.length > 20 || idInput.length < 5) {
			// Wrong ID input length
			$('#idError').html("ID length should be 5~20 characters");
			idCheck = false;
		}

		if (idCheck) {
			// OK
			$('#userID').css('border-color', 'white');
			$('#idError').addClass("hidden");
			$('#idCheckIcon').css('color', 'green');
		}
		else {
			// wrong input
			$('#userID').css('border-color', 'red');
			$('#idError').removeClass("hidden");
			$('#idCheckIcon').css('color', 'rgba(1,1,1,0)');
		}


	}
	function PasswordCheck() {
		passwordCheck = true;
		// password regular expression
		var passwordRule = /^.*(?=^.{6,20}$)(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&+=*]).*$/;
		passwordInput = $('#userPassword').val();

		if (!passwordRule.test(passwordInput)) {
			// Password invalid
			$('#userPassword').css('border-color', 'red');
			$('#passwordError').html("Requirement: at least 6 characters, one capital letter, one lowercase letter, at least one digit and one special character!");
			$('#passwordError').removeClass("hidden");
			$('#passwordCheckIcon').css('color', 'rgba(1,1,1,0)');

			passwordCheck = false;
		}
		if (passwordInput.length == 0) {
			// No input
			$('#passwordError').html("Please enter your password!");
		}
		if (passwordInput.length > 20){
			// Wrong password length
			$('#passwordError').html("Password length should be 6~20 characters");
		}
		if (passwordCheck) {
			// OK
			$('#userPassword').css('border-color', 'white');
			$('#passwordError').addClass("hidden");
			$('#passwordCheckIcon').css('color', 'green');
			ConfirmCheck();
		}
	}
	function ConfirmCheck() {
		confirmCheck = true;
		confirmInput = $('#Confirm').val();

		if (confirmInput != passwordInput) {
			// Password does not match
			$('#confirmError').html("Password does not match!");
			$('#confirmError').removeClass("hidden");

			confirmCheck = false;
		}
		if (confirmInput.length == 0) {
			// No input
			$('#confirmError').html("Please re-enter your password!");
			$('#confirmError').removeClass("hidden");

			confirmCheck = false;
		}
		if (confirmInput.length > 20){
			// Wrong password length
			$('#confirmError').html("Password length should be 6~20 characters");
			$('#confirmError').removeClass("hidden");
			
			confirmCheck = false;
		}
		if (confirmCheck) {
			// OK
			$('#Confirm').css('border-color', 'white');
			$('#confirmError').addClass("hidden");
			$('#confirmCheckIcon').css('color', 'green');
			if (!passwordCheck) {
				$('#confirmError').html("Requirement: at least 6 characters, one capital letter, one lowercase letter, atleast one digit and one special character!");
				confirmCheck = false;
			}
		}
		if (!confirmCheck) {
			// wrong input
			$('#Confirm').css('border-color', 'red');
			$('#confirmError').removeClass("hidden");
			$('#confirmCheckIcon').css('color', 'rgba(1,1,1,0)');
		}
	}
	/////////////////////////////
	// LoginPage input checking functions, similar with assignment 4
	function LoginIdCheck() {
		idCheck = true;
		idInput = $('#LoginID').val();
		
		if (idInput.length > 20 || idInput.length < 5) {
			// Wrong ID input length
			$('#idError').html("ID length should be 5~20 characters");
			idCheck = false;
		}
		if (idInput.length == 0) {
			// No input
			$('#idError').html("Please enter your ID!");

			idCheck = false;
		}

		if (idCheck) {
			// OK
			$('#LoginID').css('border-color', 'white');
			$('#idError').addClass("hidden");
			$('#idCheckIcon').css('color', 'green');
		}
		else {
			// wrong input
			$('#LoginID').css('border-color', 'red');
			$('#idError').removeClass("hidden");
			$('#idCheckIcon').css('color', 'rgba(1,1,1,0)');
		}
	}
	function LoginPasswordCheck() {
		passwordCheck = true;
		passwordInput = $('#LoginPassword').val();

		
		if (passwordInput.length == 0) {
			// No input
			$('#LoginPassword').css('border-color', 'red');
			$('#passwordError').html("Please enter your password!");
			$('#passwordError').removeClass("hidden");
			$('#passwordCheckIcon').css('color', 'rgba(1,1,1,0)');
			
			passwordCheck = false;
		}
		if (passwordInput.length > 20 || passwordInput.length < 6){
			// Wrong password length
			$('#LoginPassword').css('border-color', 'red');
			$('#passwordError').html("Password length should be 6~20 characters");
			$('#passwordError').removeClass("hidden");
			$('#passwordCheckIcon').css('color', 'rgba(1,1,1,0)');
			
			passwordCheck = false;
		}
		if (passwordCheck) {
			// OK
			$('#LoginPassword').css('border-color', 'white');
			$('#passwordError').addClass("hidden");
			$('#passwordCheckIcon').css('color', 'green');
		}
	}
	/////////////////////////////
	/* WritePage, UpdatePage input checking functions */
	function TitleControl(){
		var input = $('.post-title').val();
		var count = input.length;
		
		// If the post's title exceeds 45 length, slice the input.
		if(count>45){
			alert("Title cannot exceeds 45 characters");
			$('.post-title').val(input.slice(0, 45));
		}
	}
	
	function ContentControl() {
		var input = $('.post-content').val();
		var count = input.length;
		
		// If the post's content exceeds 2048 length, slice the input.
		if(count>2048){
			alert("Content cannot exceeds 2048 characters");
			$('.post-content').val(input.slice(0, 2048));
			count=$('.post-content').val().length;
		}
		$('.post-counter').html("Content : " + count.toString() + " / 2048");
	}
	///////////////////////////////////////
	/* SignupPage and LoginPage button functions, similar with assignment 4 */
	$("#SignupButton").click(function() {
		// Check everything is ok
		if (nameCheck && emailCheck && idCheck && passwordCheck && confirmCheck) {
			$('.sign-form').submit();
			// Form initialization
			$('.sign-form')[0].reset();

			nameCheck = false;
			emailCheck = false;
			idCheck = false;
			passwordCheck = false;
			confirmCheck = false;
			$('#nameCheckIcon').css('color', 'rgba(1,1,1,0)');
			$('#emailCheckIcon').css('color', 'rgba(1,1,1,0)');
			$('#idCheckIcon').css('color', 'rgba(1,1,1,0)');
			$('#passwordCheckIcon').css('color', 'rgba(1,1,1,0)');
			$('#confirmCheckIcon').css('color', 'rgba(1,1,1,0)');
		}
		else {
			// Something wrong
			if (!nameCheck) NameCheck();
			if (!emailCheck) EmailCheck();
			if (!idCheck) IdCheck();
			if (!passwordCheck) PasswordCheck();
			if (!confirmCheck) ConfirmCheck();
		}

	});
	$("#LoginButton").click(function() {
		// Check everything is ok
		if (idCheck && passwordCheck) {
			$('.sign-form').submit();
			// Form initialization
			$('.sign-form')[0].reset();


			idCheck = false;
			passwordCheck = false;

			$('#idCheckIcon').css('color', 'rgba(1,1,1,0)');
			$('#passwordCheckIcon').css('color', 'rgba(1,1,1,0)');
		}
		else {
			// Something wrong
			if (!idCheck) LoginIdCheck();
			if (!passwordCheck) LoginPasswordCheck();
		}
	});
	///////////////////////////////////////
	/* On the WritePage and UpdatePage, check the input length */
	$('.post-title').keyup(TitleControl);
	$('.post-title').keypress(TitleControl);
	$('.post-content').keyup(ContentControl);
	$('.post-content').keypress(ContentControl);

	///////////////////////////////////////
	/* Check SignupPage input */
	$('#userName').keyup(NameCheck);
	$('#userEmail').keyup(EmailCheck);
	$('#userID').keyup(IdCheck);
	$('#userPassword').keyup(PasswordCheck);
	$('#Confirm').keyup(ConfirmCheck);
	
	////////////////////////////////////////
	/* Check LoginPage input */
	$('#LoginID').keyup(LoginIdCheck);
	$('#LoginPassword').keyup(LoginPasswordCheck);
	///////////////////////////////////////
	// Contact form message sending function
	$('#SendButton').click(function(){
		var nameInput = $('#contactName').val();
		var infoInput = $('#contactInfo').val();
		var msgInput = $('#contactMessage').val();
		var check=true;
		if(nameInput.length > 20 || infoInput.length > 20){
			// Over input
			alert("Your name and information cannont exceeds 20 characters");
			check=false;
		}
		if(msgInput.length > 100){
			// Over input
			alert("Your message cannot exceeds 100 characters");
			check=false;
		}
		
		if(nameInput.length==0 || infoInput.length==0 || msgInput.length==0){
			// Missing input
			alert("Please fill the form");
			check=false;
		}
		// OK
		if(check) {
			// Submit the form
			$('.contact-form').submit();
			// Clear the form
			$('.contact-form')[0].reset();			
		}
	});
});
