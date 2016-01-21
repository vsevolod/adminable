#= require active_admin/base
#= require jsoneditor.min
#= require jsoneditor_activeadmin_integration


update_as_items = ->
  $.get( "/categories/#{$('#item_category_id').val()}/by_id", {item_id: $('#item_id').val()}, (data) ->
    $('#as_items').html(data)
  )
  

$( ->
  $('#item_category_id').on 'change', update_as_items
  update_as_items()
)
