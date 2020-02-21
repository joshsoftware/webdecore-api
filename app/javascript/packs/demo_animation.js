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
  	}
	};
var anim = bodymovin.loadAnimation(animData);
setStyle();

function setStyle(){
  var html = animData.container.getElementsByClassName("lottie")[0];
  html.style.position = "fixed";
  html.style.top = 0;
  html.style.left = 0;
  html.style.pointerEvents = "none";
  anim.setSubframe(false);
  }

animationComplete = function(){
  var element = animData.container.getElementsByClassName("lottie")[0];
  element.parentNode.removeChild(element);
  setTimeout(timer, 5000);
  }
anim.onComplete = animationComplete;

function timer(){
  var anim = bodymovin.loadAnimation(animData);
  setStyle();
  anim.onComplete = animationComplete;
  }
}

setDate = function(start_date){
  document.getElementById('end_date').min = start_date
}
