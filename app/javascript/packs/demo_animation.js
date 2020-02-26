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
  setTimeout(function () {
    var html = animData.container.getElementsByClassName("lottie")[0];
    html.style.position = "fixed";
    html.style.top = 0;
    html.style.left = 0;
    html.style.pointerEvents = "none";
  }, 100);
}

setDate = function(start_date){
  document.getElementById('end_date').min = start_date
}
