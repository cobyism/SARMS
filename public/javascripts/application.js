// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

document.observe('dom:loaded', function() {
  setTimeout(hideFlashes, 2000);
});

var hideFlashes = function() {
  $$('#flash').each(function(e) {
	if (e) Effect.SlideUp(e, { duration: 1 });
	if (e) Effect.Fade(e, { duration: 1 });
  })
}