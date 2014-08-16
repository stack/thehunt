jQuery ->

  $('.sortable').sortable(
    axis: 'y'
    items: '.item'

    update: (e, ui) ->
      parent = this
      url = $(parent).data('url')

      order = $(parent).sortable('toArray').map (child) ->
        $('#' + child).data('item-id')

      $.ajax(
        type: 'POST'
        url: url
        dataType: 'json'
        data: { order: order }
      )
  )

  $('.sortable').sortable('disable')

