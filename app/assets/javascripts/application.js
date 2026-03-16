// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require turbo
//= require_tree .

document.addEventListener('turbo:load', function() {
  var uploadField = document.querySelector('.upload');
  var imageFrame = document.querySelector('.image-frame');

  if (!uploadField || !imageFrame) {
    return;
  }

  uploadField.addEventListener('change', function(event) {
    var files = event.target.files;
    var image = files && files[0];
    var reader;

    if (!image) {
      imageFrame.innerHTML = '';
      return;
    }

    reader = new FileReader();
    reader.onload = function(file) {
      var img = new Image();

      img.src = file.target.result;
      img.alt = 'Recipe preview';
      imageFrame.innerHTML = '';
      imageFrame.appendChild(img);
    };

    reader.readAsDataURL(image);
  });
});
