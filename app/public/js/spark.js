$(document).ready(function() {
  
  function hide_alert(){

    console.log('done')
    $('.alert').hide();

  }

  $('.btn').on('click',function(){

      setTimeout( function(){ $('.alert').hide();},10000 )

  })

  
});