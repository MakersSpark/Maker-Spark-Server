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

    if(actual_count<10) total_count.css('color', 'red');

    if(actual_count === 0)  event.stopPropagation();

  });


  
  function hide_alert(){

    console.log('done')
    $('.alert').hide();

  }

  $('.btn').on('click',function(){

      setTimeout( function(){ $('.alert').hide();},10000 )

  })


  
});

  // $('.modal_main textarea').on('keyup',function(){

  //   var count, total_count, actual_count;

  //   count        = $(this).val().length;
    
  //   total_count  = $('.modal_footer .total_count');
        
  //   actual_count = (140-count);

  //   total_count.text(actual_count);

  //   if(actual_count<0) total_count.css('color', 'red');

  //   $('button.send_tweet').css('opacity', '1');
  //   $('button.send_tweet').attr('disabled', false)

  //   if(actual_count===140){

  //     $('button.send_tweet').css('opacity', '0.4');
  //     $('button.send_tweet').attr('disabled', true)
  //   } 
      
  // })