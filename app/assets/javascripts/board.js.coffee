logDebug = false

# Created by STRd6
# MIT License
# jquery.paste_image_reader.js.coffee

$.event.fix = ((originalFix) ->
  (event) ->
    event = originalFix.apply(this, arguments)

    if event.type.indexOf('copy') == 0 || event.type.indexOf('paste') == 0
      event.clipboardData = event.originalEvent.clipboardData

    return event

)($.event.fix)

defaults =
  callback: $.noop
  matchType: /image.*/

$.fn.pasteImageReader = (options) ->
  if typeof options == "function"
    options =
      callback: options

  options = $.extend({}, defaults, options)

  this.each ->
    element = this
    $this = $(this)

    $this.bind 'paste', (event) ->
      found = false
      clipboardData = event.clipboardData

      Array::forEach.call clipboardData.types, (type, i) ->
        return if found

        if type.match(options.matchType) or clipboardData.items[i].type.match(options.matchType)
          file = clipboardData.items[i].getAsFile()
          uploadBlob file

          reader = new FileReader()

          reader.onload = (evt) ->
            options.callback.call element,
              dataURL: evt.target.result
              event: evt
              file: file
              name: file.name

          reader.readAsDataURL(file)

          found = true

uploadBlob = (blob) ->
  console.log "uploadBlob: blob", blob if logDebug
  fd = new FormData()
  fd.append "files", blob, "filename"

  $.ajax
    type: "POST"
    data: fd
    url: window.filesUrl
    cache: false
    contentType: false
    processData: false
    success: (data) ->
      console.log "data", data if logDebug
      Images.add(data)

$("html").pasteImageReader (results) ->
  console.log "show last upload" if logDebug
  $("#last-upload").show()

Image = Backbone.Model.extend()

ImagesCollection = Backbone.Collection.extend
  model: Image
  url: window.filesUrl
  comparator: (image) ->
    sortDate = image.get("createdAt") if logDebug
    0-Date.parse(sortDate)

Images = new ImagesCollection([])

redoImageCollection = ->
  $("#last-upload").hide()
  Images.fetch()

redoImageCollection()

ThumbView = Backbone.View.extend
  className: "image-thumb"
  template: _.template( $('#thumb-template').html() )
  render: ->
    console.log "render thumbview" if logDebug
    @$el.html( @template( @model.toJSON() ) )
    this
  initialize: ->
    console.log "init thumbview" if logDebug

ImagesView = Backbone.View.extend
  el: '#images'
  render: ->
    @$el.show()
    this
  initialize: ->
    console.log("images view initialize") if logDebug
    @listenTo(Images, 'add', @addOne)
    @render()
  addOne: (image) ->
    console.log "image view add one", image if logDebug
    view = new ThumbView({ model: image })
    $("#images").prepend( view.render().el )

imagesView = new ImagesView()

console.log "images", Images if logDebug

window.pbRefresh = setInterval ->
  redoImageCollection()
, 1000
