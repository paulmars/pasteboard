$(function() {
  function r(r) {
    var i = $(n),
        s = $("img", i);
    var o = new FileReader;
    s.width = 100;
    s.height = 100;
    o.onload = function(e) {
      s.attr("src", e.target.result)
    };
    o.readAsDataURL(r);
    t.hide();
    i.appendTo(e);
    $.data(r, i)
  }
  function i(e) {
    t.html(e)
  }
  var e = $("#dropbox"),
      t = $(".message", e);
  e.filedrop({
    paramname: "files",
    maxfiles: 100,
    maxfilesize: 25,
    url: window.filesUrl,
    uploadFinished: function(e, t, n) {
      $.data(t).addClass("done")
    },
    error: function(e, t) {
      switch (e) {
      case "BrowserNotSupported":
        i("Your browser does not support HTML5 file uploads!");
        break;
      case "TooManyFiles":
        alert("Too many files. Please slow down");
        break;
      case "FileTooLarge":
        alert(t.name + " is too large.");
        break;
      default:
        break
      }
    },
    beforeEach: function(e) {
      if (!e.type.match(/^image\//)) {
        alert("Only images are allowed!");
        return false
      }
    },
    uploadStarted: function(e, t, n) {
      r(t)
    },
    progressUpdated: function(e, t, n) {
      $.data(t).find(".progress").width(n + "%")
    }
  });
  var n = '<div class="preview thumbnail">' + '<span class="imageHolder">' + "<img class='img-responsive'/>" + '<span class="uploaded"></span>' + "</span>" + '<div class="progressHolder">' + '<div class="progress"></div>' + "</div>" + "</div>"
})