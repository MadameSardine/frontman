$( document ).ready(function() {
	$('.logged_in_page').hide();
	$('.right_nav').hide();
	$('.left_nav').hide();
	$('.user_input').val('');

	var name
	var username

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
					$('#flash').show();
					$('#flash p').text("The username and password you entered did not match our records. Please double-check and try again.");
					$('#close').on('click',function(){
					$('#flash').hide();
					$('#flash p').empty();
					});
				}
				else {
					console.log(json);
					$('.logged_out_page').hide();
					$('.logged_in_page').show();
					$('.right_nav').show();
					$('.left_nav').show();
					name = json["name"]
					console.log(name)
					username = json["username"]
					$('#my_name').text(name);
			      	$('#my_username').text("@" + username);
			      	$('.user_input').val('');
				}
			}
		})
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
	});

	$('#sign_out_button').on('click',function(){
		$('.user_input').empty();
		$('#flash').show();
		$('#flash p').text("Good bye");
		$('.logged_in_page').hide();
		$('.right_nav').hide();
		$('.left_nav').hide();
		$('.logged_out_page').show();
	});
	

	$('#close').on('click',function(){
		$('#flash').hide();
		$('#flash p').empty();
	});
});



		


		
		

		


