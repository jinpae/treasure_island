$(document).on 'page:change', ->
	$('#flash-wrapper').fadeIn 1200

	setTimeout ->
		$('#flash-wrapper').fadeOut 'slow', ->
			$(this).remove()
	, 4000

	$('#flash-wrapper .close').on 'click', (e) ->
		e.preventDefault()
		flashWrapper = $('#flash-wrapper')
		flashWrapper.off()
		flashWrapper.fadeOut 'slow', ->
			flashWrapper.remove()

$(document).on 'page:before-unload', ->
	$('#flash-wrapper').off()
