$(document).on('turbolinks:load', ->
  $(".deletion_confirmation").click( ->
    $("#delete").show()
  )
)