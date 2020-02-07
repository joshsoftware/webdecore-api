show = function(animation){
	var animData = {
    container: document.body,
  	animType: 'svg',
  	loop: true,
  	prerender: true,
  	autoplay: true,
    animationData: animation,
  	rendererSettings: {
      className: 'lottie',
  		preserveAspectRatio: 'none',
  	}
	};
var anim = bodymovin.loadAnimation(animData);
setTimeout(function () {
  var html = animData.container.getElementsByClassName("lottie")[0];
  html.style.position = "fixed";
  html.style.zIndex = -999;
  html.style.top = 0;
  html.style.left = 0;
	}, 100);
}

setDate = function(start_date){
  document.getElementById('end_date').min = start_date
}
