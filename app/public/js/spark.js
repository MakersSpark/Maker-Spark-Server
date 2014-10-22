$(document).ready(function() {
  
	// elastic jquery plugin for textarea

  $('.paper_printer').elastic();


  // word counting for textarea

  $('.paper_printer').on('keyup',function(){

    var count, total_count, actual_count;

    count        = $(this).val().length;
    
    total_count  = $('.total_count');
        
    actual_count = (96-count);

    total_count.text('Words left ' + actual_count);

    if(actual_count <= 10) total_count.css('color', 'red');

  });


  
  function hide_alert(){

    console.log('done')
    $('.alert').hide();

  }

  $('.btn').on('click',function(){

      setTimeout( function(){ $('.alert').hide();},10000 )

  })


  
});
