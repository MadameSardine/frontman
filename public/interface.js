function showLoggedOutPage(){
	$('.logged_out_page').show();
	$('.logged_in_page').hide();
	$('.right_nav').hide();
	$('.left_nav').hide();
	$('.user_input').val('');	
}

function listAllPeeps(){
	closeFlashWindow();
	clearTempPeeps();
	$('#all_peeps').show();
}

function showLoggedInPage(){
	$('.logged_out_page').hide();
	$('.logged_in_page').show();
	$('.right_nav').show();
	$('.left_nav').show();
	$('.user_input').val('');	
}

function fillEmptyErrorMessage(){
	$('#flash').show();
	$('#flash p').text("Please fill all field in the form to sign up.");
	$('.user_input').val('');
}

function passwordNoMatchErrorMessage(){
	$('#flash').show();
	$('#flash p').text("Passwords don't match.");
	$('.user_input').val('');
}

function loginCredentialsError(){
	$('#flash').show();
	$('#flash p').text("The username and password you entered did not match our records. Please double-check and try again.");
	$('.user_input').val('');
}

function loginCredentialsAlreadyUsed(){
	$('#flash').show();
	$('#flash p').text("The username or the email is already used.");
	$('.user_input').val('');
}

function userNotFoundErrorMessage(){
	$('#flash').show();
	$('#flash p').text("This user is not on Chitter.");
	$('#profile_name').val('');
}

function goodByeMessage(){
	$('#flash').show();
	$('#flash p').text("Good bye");
}

function closeFlashWindow(){
	$('#flash').hide();
	$('#flash p').empty();
}

function clearTempPeeps(){
	$('#user_peeps').empty();
	$('#temporary_peeps').empty();
}

$( document ).ready(function() {

	showLoggedOutPage();
	
	var name
	var username

	$('#home').on('click',function(){
		$('#user_peeps').empty();
		$('#all_peeps').show();
		closeFlashWindow();
	});

	$('#sign_up_button').on('click',function(){
		listAllPeeps();
		name = $('#new_name').val();
		username = $('#new_username').val();
		email = $('#new_email').val();
		password = $('#new_password').val();
		password_confirmation = $('#new_password_confirmation').val();
		
		if (name === '' || username === '' || email === '' || password === '') {fillEmptyErrorMessage()}

		else if (password !== password_confirmation){
			passwordNoMatchErrorMessage()
		}

		else{

		var javascriptData = {"name": name, "username": username, "email": email, "password": password, "password_confirmation": password_confirmation};
		var data = JSON.stringify(javascriptData);

			$.ajax({
			url: '/api/users/',
			type: "POST",
			data: data,
			dataType: 'json',
			contentType: 'application/json',
			accepts: 'application/json',
			success: function(json){
				if(json === null){
					loginCredentialsAlreadyUsed();
				}
				else {
					name = json["name"]
					username = json["username"]
					$('#my_name').text(name);
			      	$('#my_username').text("@" + username);
			      	showLoggedInPage();
					}
				}
			})
		}	
	});

	$('#sign_in_button').on('click',function(){
		listAllPeeps();
		var username_input = $('#username_input').val();
		var password_input = $('#password_input').val();
		var javascriptData = {"username": username_input, "password": password_input};
		var data = JSON.stringify(javascriptData);

		$.ajax({
			url: '/api/sessions/',
			type: "POST",
			data: data,
			dataType: 'json',
			contentType: 'application/json',
			accepts: 'application/json',
			success: function(json){

				if(json === null){
					loginCredentialsError();
				}
				else {
					name = json["name"]
					username = json["username"]
					$('#my_name').text(name);
			      	$('#my_username').text("@" + username);
			      	showLoggedInPage();
				}
			}
		})
	});

	$('#sign_out_button').on('click',function(){
		showLoggedOutPage();
		goodByeMessage();
	});
	
	$('#close').on('click',function(){
		closeFlashWindow();
	});

	$('#validate_peep').on('click',function(){
		closeFlashWindow();
		$('#all_peeps').show();
		var peep_content = $('#new_peep_content').val();
		var source = $('#peepTemplate').html();
		var template = Handlebars.compile(source);
		var context = {
			name: name,
			username: username,
			peepContent: peep_content
			};
	
		$('#temporary_peeps').append(template(context));
		$('#temporary_peeps article').last().addClass('peep_list');
		$('#new_peep_content').val('');	

		var javascriptData = {"content": peep_content, "username": username};
		var data = JSON.stringify(javascriptData);

		$.ajax({
			url: '/api/peeps/',
			type: "POST",
			data: data,
			dataType: 'json',
			contentType: 'application/json',
			accepts: 'application/json'
		});
	});


	$('#show_peeps').on('click',function(){
		closeFlashWindow();
		$('#all_peeps').hide();
		$('#user_peeps').hide();
		var profile_name =  $('#profile_name').val();
		var javascriptData = {"username": profile_name};
		var data = JSON.stringify(javascriptData);
		console.log(data)

		var request = $.ajax({
			url: '/api/userpeeps/' + profile_name, 
			type: "GET",
			dataType: 'json',
			contentType: 'application/json',
			accepts: 'application/json'
		});
			
		request.done(function(json){
			var name = json[0]["name"]
			var peep_length = (json[1]).length
			var peep_content = []
			var context = []
			for (i = 0; i< peep_length; i++){
				peep_content[i] = json[1][i]["content"]
				var source = $('#peepTemplate').html();
				var template = Handlebars.compile(source);
				context[i] = {
						name: name,
						username: profile_name,
						peepContent: peep_content[i]
						};
				console.log(context[i])
				$('#user_peeps').append(template(context[i]));
				$('#user_peeps article').last().addClass('peep_list');
					}
			$('#profile_name').val('');

		});

		request.fail(function(){
			userNotFoundErrorMessage()
		});
	});
});



		


		
		

		


