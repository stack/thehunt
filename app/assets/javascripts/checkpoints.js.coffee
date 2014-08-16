# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

  $('.toggle-sort').click ->
    state = $(this).data('state')
    console.log state

    if state == 'enabled'
      $(this).data('state', 'disabled')
      $('.sortable').sortable('disable')
    else
      $(this).data('state', 'enabled')
      $('.sortable').sortable('enable')

