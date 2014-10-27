$( document ).ready(function() {
	$('.logged_in_page').hide();

	$('#sign_in_button').on('click',function(){
		var username = $('#username_input').val();

		$.ajax({
			url: '/api/session/' + username,
			type: "GET",
			dataType: 'json',
			success: function(data){
				alert('ok');
				console.log(data);
				$('.logged_out_page').slideup();
				$('.logged_in_page').show();
				var name = data("name")
				$('#my_name').text(name);
		      	$('#my_username').append(username);

		      	$('#validate_peep').on('click',function(){
					var peep_content = $('#new_peep_content').val();
					var source = $('#peepTemplate').html();
					var template = Handlebars.compile(source);
					var context = {
						name: "Sandrine",
						username: username,
						peepContent: peep_content
						};
					$('#peeps').append(template(context));
					$('#peeps article').last().addClass('peep_list');
					$('#new_peep_content').val('');	
				});
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert('fail');
				console.log(data);
				$('#flash').show();
				$('#close').on('click',function(){
					$('#flash').hide();
				});
			}
		});
	});
});
