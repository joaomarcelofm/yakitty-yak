$('i').on('click', function(){

  if($(this).text() == 'check'){
    return false;
  }

  $(this).addClass('animating');

  var activeStep = $('.step.active');
  activeStep.addClass('sliding-out');
  var nextStep = activeStep.next('.step');
  nextStep.addClass('sliding-in');
  nextStep.on('animationend', function(){
    $(this).off('animationend');
    activeStep.removeClass('active sliding-out').addClass('previous');
    $(this).removeClass('next sliding-in').addClass('active');
    $('i').removeClass('animating');

    if(!$(this).next('.step').length){
      $('i').html('');
    }
    else {
      $(this).next('.step').addClass('next');
    }


  })

})

var activeStep = $('.step.active');
var isOne = activeStep.hasClass('step-1');
// console.log(isOne);
if(isOne === true){
  $(".up-arrow-form").addClass("hidden");
} else {
  $(".up-arrow-form").removeClass('hidden');
  $(".up-arrow-form").addClass('next')
};

if(isOne === false){
  $(".up-arrow-form").removeClass("hidden");}
  // $('.up-arrow-form').on('click', function(){
  //   $(this).addClass('animating');
  //   var activeStep = $('.step.active');
  //   activeStep.addClass('sliding-out');
  //   var nextStep = activeStep.next('.step');
  //   nextStep.addClass('sliding-in');
  //   nextStep.on('animationend', function(){
  //     $(this).off('animationend');
  //     activeStep.removeClass('active sliding-out').addClass('previous');
  //     $(this).removeClass('next sliding-in').addClass('active');
  //     $('i').removeClass('animating');

      // if(!$(this).next('.step').length){
      //   $('i').html('check');
      // }
      // else {
      //   $(this).next('.step').addClass('next');
      // }
// };
// };
