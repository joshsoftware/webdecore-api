  var animData = {
      container: document.body,
      animType: 'svg',
      loop: true,
      prerender: true,
      autoplay: true,
      path: "Diwali-2020.json",
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
