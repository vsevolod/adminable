#= require active_admin/base
#= require jsoneditor.min
#= require jsoneditor_activeadmin_integration


update_as_items = ->
  $.get( "/categories/#{$('#item_category_id').val()}/by_id", {item_id: $('#item_id').val()}, (data) ->
    $('#as_items').html(data)
  )
  

$( ->
  if $('#item_category_id').length > 0
    $('#item_category_id').on 'change', update_as_items
    update_as_items()

  $.each($('.sortable'), (index, item) ->
    $(item).sortable({
      placeholder: "ui-state-highlight"
      update: (event, ui) ->
        console.log(ui)
        console.log(ui.item)
        url = ui.item.data('sort-url')
        console.log(url)
        $.ajax({
                  url: url,
                  type: 'post',
                  data: { position: ui.item.index() + 1 },
                  success: ->
                    window.location.reload()
        })
    })
  )
  #$('#sortable_0').sortable({placeholder: "ui-state-highlight"})

)
