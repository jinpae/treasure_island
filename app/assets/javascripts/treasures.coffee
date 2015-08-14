$(document).on 'page:change', ->
	$('.heart-wrapper a').bind 'ajax:error', (e, xhr, settings, error) ->
		if xhr.status == 401
			window.location.replace(this)
