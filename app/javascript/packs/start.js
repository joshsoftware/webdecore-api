var frequency;
var anim;
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
  frequency = sessionStorage.getItem('frequency');
  if(animation === null){
    var xhttp = new XMLHttpRequest();
    xhttp.open("GET","http://localhost:3000/api/v1/animation_datas?uuid="+user+"&location="+loc,true);
    xhttp.send();
    xhttp.onreadystatechange = function(){
      if(this.readyState == 4 && this.status == 200){
        if(this.responseText != "{}") {
          response_data = JSON.parse(this.responseText);
          animation_json  = response_data["animation"];
          frequency = response_data["frequency"];
          sessionStorage.setItem('animation',animation_json);
          sessionStorage.setItem('frequency',response_data["frequency"])
          playAnimation(JSON.parse(animation_json))
        }
      };
    }
  }
  else{
    if(this.responseText != "{}"){
      animation_json = JSON.parse(animation);
      playAnimation(animation_json);
    }
  }
}

function playAnimation(animation){
  var animData = {
    container:document.body,
    animType:'svg',
    loop:1,
    prerender:true,
    autoplay:true,
    animationData:animation,
    rendererSettings:{
      className:'lottie',
      preserveAspectRatio:'none',
    }
  }

  if(document.getElementsByClassName("lottie").length == 0){
    anim = bodymovin.loadAnimation(animData);
    setStyle();
    anim.setSubframe(false);
  }
  else{
    anim = document.getElementsByClassName("lottie")[0];
    document.body.removeChild(anim);
    anim = bodymovin.loadAnimation(animData);
    setStyle();
    anim.setSubframe(false);
  }
  function setStyle(){
    var html = animData.container.getElementsByClassName("lottie")[0];
    html.style.position = "fixed";
    html.style.pointerEvents = "none";
    html.style.background = "transparent";
    html.style.top = 0;
    html.style.left = 0;
  }
  function animationComplete(){
    var element = animData.container.getElementsByClassName("lottie")[0];
    element.parentNode.removeChild(element);
    setTimeout(timer, frequency*1000);
  }
  anim.onComplete = function() {
    var element = animData.container.getElementsByClassName("lottie")[0];
    element.parentNode.removeChild(element);
    setTimeout(timer, frequency*1000);
  }

  function timer(){
    anim = bodymovin.loadAnimation(animData);
    setStyle();
    anim.onComplete = function() {
      var element = animData.container.getElementsByClassName("lottie")[0];
      element.parentNode.removeChild(element);
      setTimeout(timer, frequency*1000);
    }
  }
}
