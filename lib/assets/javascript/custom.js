// javascript/packs/custom.js

window.addEventListener("load",() => {
  var img = document.createElement('img');
  //img.src = 'https://66.media.tumblr.com/849c4259435e5ff9789dd42e23fbf003/tumblr_p422nhq6vi1qzm8dwo1_500.gifv';
  img.src = 'https://media1.tenor.com/images/a9fcb8de8543181c0002a68e77973837/tenor.gif?itemid=14358079';
  img.width = 100;
  img.height = 100;
  console.log(img.width, img.height);
  document.getElementsByTagName('body')[0].appendChild(img);
  var vpWidth = document.documentElement.clientWidth;
  var vpHeight = document.documentElement.clientHeight;
  img.style.position = 'absolute';
  var dleft = (vpWidth - img.offsetWidth)/2 + 'px';
  img.style.left = dleft;
  var dtop =  (vpHeight - img.offsetHeight)/2 + window.pageYOffset + 'px';
  img.style.top = dtop;
});