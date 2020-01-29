check = function(animation_name){
    var canvas = document.getElementsByTagName("canvas")[0];
    if(canvas !== undefined){
    document.body.removeChild(canvas);
    console.log(animation_name);
    show(animation_name);
    }
    else {
      console.log(animation_name);
      show(animation_name);
    }
}
show = function(animation_name){

  var file_name = "/"+animation_name+".json";
  console.log(animation_name);
  console.log(file_name);
  console.log("show");
		var animData = {
  			container: document.body,
  			animType: 'canvas',
  			loop: true,
  			prerender: true,
  			autoplay: true,
  			path: file_name,
  			rendererSettings: {
          context: document.body,
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
