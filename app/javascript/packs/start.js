var script = document.createElement('script');
script.type = 'text/javascript';
script.src = 'https://cdnjs.cloudflare.com/ajax/libs/bodymovin/5.5.9/lottie.js';
document.head.appendChild(script);

var script = document.createElement('script');
script.type = 'text/javascript';
script.src = 'https://geoip-db.com/jsonp/';
document.head.appendChild(script);

window.callback = function(data){
 loc = data.state;
 var animation = sessionStorage.getItem('animation');
 if(animation === null){
   var xhttp = new XMLHttpRequest();
   xhttp.open("GET", "http://192.168.1.100:3000/api/v1/animation_datas?user_id="+user+"&location="+loc, true);
   xhttp.send();
   xhttp.onreadystatechange = function() {
     if (this.readyState == 4 && this.status == 200) {
       animation1 = JSON.parse(this.responseText);
       sessionStorage.setItem('animation',this.responseText);
       playAnimation(animation1)
     }
   };
 }
 else{
   var animation1 = JSON.parse(animation);
   playAnimation(animation1);
 }
}

function playAnimation(animation){
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
 }
 else {
   var anim = document.getElementsByClassName("lottie")[0];
   document.body.removeChild(anim);
   anim = bodymovin.loadAnimation(animData);
 }
 var html = animData.container.getElementsByClassName("lottie")[0];
 html.style.position = "fixed";
 html.style.pointerEvents = "none";
 html.style.background = "transparent";
 html.style.top = 0;
 html.style.left = 0;
}
