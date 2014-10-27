$( document ).ready(function() {
	$('.logged_in_page').hide();
	$('.right_nav').hide();
	$('.left_nav').hide();

	$('#sign_in_button').on('click',function(){
		var username_input = $('#username_input').val();
		var password_input = $('#password_input').val();
		var javascriptData = {"username": username_input, "password": password_input}
		var data = JSON.stringify(javascriptData);

		var request = $.ajax({
			url: '/api/sessions/',
			type: "POST",
			data: data,
			dataType: 'json',
			contentType: 'application/json',
			accepts: 'application/json'
		});
			request.done(function(data){
				$.getJSON('/api/sessions/' + username_input, function (data){

					if(data !== null) {

					console.log(data);
					$('.logged_out_page').hide();
					$('.logged_in_page').show();
					$('.right_nav').show();
					$('.left_nav').show();
					var name = data["name"]
					var username = data["username"]
					$('#my_name').text(name);
			      	$('#my_username').append(username);

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

			    } 
			    
			    else {
					console.log(data);
					$('#flash').show();
					$('#close').on('click',function(){
					$('#flash').hide();
					});
			    }	

				});
	
			}),
			request.fail(function(jqXHR, textStatus, errorThrown){
				alert('fail');
				console.log(data);
				$('#flash').show();
				$('#close').on('click',function(){
					$('#flash').hide();
				});
			});
	});
});
