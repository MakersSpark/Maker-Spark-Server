$(document).ready(function() {

	// Removing flash error/notice

	window.setTimeout(function() {
        $(".alert").fadeTo(4500, 0).slideUp(500, function(){
            $(this).remove();
        });
    }, 4000);
  
	// Elastic jquery plugin for textarea

  $('.paper_printer').elastic();


  // Word counting for textarea

  $('.paper_printer').on('keyup',function(){

    var count, total_count, actual_count;

    count        = $(this).val().length;
    
    total_count  = $('.total_count');
        
    actual_count = (96-count);

    total_count.text(actual_count);

    if(actual_count <= 10) total_count.css('color', 'red');

  });


 //  // Add selected Github user to textarea

 //  $( ".paper_printer" ).focus(function() {
  	
 //  	$(this).text('Hi ' + $('select').val()+ '!!')
	// });


  // Collapsing input for search term

  $('#SearchTerm').hide();
  $('#SearchMap').hide();

  $('#TwitterData').click(function() {
  	$('#SearchTerm').fadeIn('slow').toggle(this.checked)
  });


  $('#GoogleMaps').click(function() {
  	$('#SearchMap').fadeIn('slow').toggle(this.checked)
  });

});


