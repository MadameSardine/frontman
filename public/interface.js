function showLoggedOutPage(){
	$('.logged_out_page').show();
	$('.logged_in_page').hide();
	$('.right_nav').hide();
	$('.left_nav').hide();
	$('.user_input').val('');	
}

function showLoggedInPage(){
	$('.logged_out_page').hide();
	$('.logged_in_page').show();
	$('.right_nav').show();
	$('.left_nav').show();
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

function goodByeMessage(){
	$('#flash').show();
	$('#flash p').text("Good bye");
}

function closeFlashWindow(){
	$('#flash').hide();
	$('#flash p').empty();
}

$( document ).ready(function() {

	showLoggedOutPage();
	
	var name
	var username

	$('#sign_up_button').on('click',function(){
		var name = $('#new_name').val();
		var username = $('#new_username').val();
		var email = $('#new_email').val();
		var password = $('#new_password').val();
		var password_confirmation = $('#new_password_confirmation').val();
		var javascriptData = {"name": name, "username": username, "email": email, "password": password, "password_confirmation": password_confirmation};
		var data = JSON.stringify(javascriptData);

		if (password !== password_confirmation){
			passwordNoMatchErrorMessage()
		}

		else{

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
					console.log(json);
					name = json["name"]
					console.log(name)
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
		var peep_content = $('#new_peep_content').val();
		var source = $('#peepTemplate').html();
		var template = Handlebars.compile(source);
		var context = {
			name: name,
			username: username,
			peepContent: peep_content
			};
		$('#peeps').append(template(context));
		$('#peeps article').last().addClass('peep_list');
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
});



		


		
		

		


