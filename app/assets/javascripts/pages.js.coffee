# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(".pages.crop").ready ->
  new AvatarCropper()

class AvatarCropper
  constructor: ->
    $('#cropbox').Jcrop
      aspectRatio: 1
      setSelect: [100, 100, 404, 404]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $('#user_crop_x').val(coords.x)
    $('#user_crop_y').val(coords.y)
    $('#user_crop_w').val(coords.w)
    $('#user_crop_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
    console.log("&&")
    console.log(Math.round(304/coords.w * $('#cropbox').width()) + 'px')
    $('#preview').css
      width: Math.round(304/coords.w * $('#cropbox').width()) + 'px'
      height: Math.round(304/coords.h * $('#cropbox').height()) + 'px'
      marginLeft: '-' + Math.round(304/coords.w * coords.x) + 'px'
      marginTop: '-' + Math.round(304/coords.h * coords.y) + 'px'