$(document).on 'page:change', ->
	$('.navbar-toggle').on 'click', ->
		$('nav ul').toggleClass('navbar-collapse-toggle')
