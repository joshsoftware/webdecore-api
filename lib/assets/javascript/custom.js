// javascript/packs/custom.js

window.animate =function() {
  alert('hello');
  var img = document.createElement('img');
  //img.src = 'https://66.media.tumblr.com/849c4259435e5ff9789dd42e23fbf003/tumblr_p422nhq6vi1qzm8dwo1_500.gifv';
  img.src = 'https://media1.tenor.com/images/a9fcb8de8543181c0002a68e77973837/tenor.gif?itemid=14358079'
  //img.width = 1000;
  img.width = 100;
  document.getElementById('body').appendChild(img);
}

