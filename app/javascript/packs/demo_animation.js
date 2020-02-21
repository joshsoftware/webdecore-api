show = function(animation){
  animation= JSON.parse(animation);
	var animData = {
    container: document.body,
  	animType: 'svg',
  	loop: 1,
  	prerender: true,
  	autoplay: true,
    animationData: animation,
  	rendererSettings: {
      className: 'lottie',
  		preserveAspectRatio: 'none',
      progressiveLoad: true
  	}
	};
var anim = bodymovin.loadAnimation(animData);
setTimeout(function () {
  var html = animData.container.getElementsByClassName("lottie")[0];
  html.style.position = "fixed";
  html.style.top = 0;
  html.style.left = 0;
  html.style.pointerEvents = "none";
	}, 100);
  anim.setSubframe(false);
  anim.onComplete = function(){
    console.log("comp")
   var element = animData.container.getElementsByClassName("lottie")[0];
   element.parentNode.removeChild(element);
   setTimeout(time, frequency);
  }
  function time(){
    console.log("timer")
    var anim = bodymovin.loadAnimation(animData);
    var html = animData.container.getElementsByClassName("lottie")[0];
    html.style.position = "fixed";
    html.style.top = 0;
    html.style.left = 0;
    html.style.pointerEvents = "none";
    anim.onComplete = function(){
    console.log("comp")
     var element = animData.container.getElementsByClassName("lottie")[0];
     element.parentNode.removeChild(element);
     setTimeout(time, frequency);
    }
  }
}

setDate = function(start_date){
  document.getElementById('end_date').min = start_date
}
var frequency = 5000;
