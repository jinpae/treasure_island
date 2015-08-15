$(document).on 'page:change', ->
	$('.lead').fitText(1, { minFontSize: '44px', maxFontSize: '54px' })
