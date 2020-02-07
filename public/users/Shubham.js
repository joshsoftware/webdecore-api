var user= 's@n.com';var script = document.createElement('script');
script.type = 'text/javascript';
script.src = 'https://geoip-db.com/jsonp/';
document.head.appendChild(script);

window.callback = function(data){
  country = data.country_name;
  console.log(country);

  var xhttp = new XMLHttpRequest();
  xhttp.open("GET", "http://192.168.1.98:3000/api/v1/animation/?country="+country, true);
  xhttp.send();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      var animation = JSON.parse(this.responseText);
      console.log(animation);
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
     }
     if(document.getElementsByClassName("lottie").length == 0){
       var anim = bodymovin.loadAnimation(animData);
       console.log("if");
     }
     else {
        var anim = lottie.searchAnimations();
       console.log(anim);
       var anim = document.getElementsByClassName("lottie")[0];
       document.body.removeChild(anim);
       anim = bodymovin.loadAnimation(animData);
       console.log("else");
     }
     //setTimeout(style(),200);
     var html = animData.container.getElementsByClassName("lottie")[0];
     html.style.position = "fixed";
     html.style.zIndex = -999;
     html.style.top = 0;
     html.style.left = 0;
     console.log("timeout");
    }
  };
}
