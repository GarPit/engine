Locomotive.Views.ContentAssets ||= {}

class Locomotive.Views.ContentAssets.PickerItemView extends Backbone.View

  tagName: 'li'

  className: 'asset'

  events:
    'click h4 a, .icon, .image':  'select_asset'
    'click a.remove':             'remove_asset'

  render: ->
    $(@el).html(ich.content_asset(@model.toJSON()))

    return @

  refresh: ->
    $(@el).html(ich.content_asset(@model.toJSON()))

  uploaded_at: (loaded, total) ->
    percentage = (loaded / total) * 100

    # for UI reasons, it's better to have it begin at 20%.
    percentage = 20 if percentage < 20

    # update the progress bar
    @$('.uploading .progress-bar').css('width', "#{percentage}%")

  select_asset: (event) ->
    event.stopPropagation() & event.preventDefault()
    @on_select(@model)

  on_select: ->
    @options.parent.options.on_select(@model) if @options.parent.options.on_select

  remove_asset: (event) ->
    event.stopPropagation() & event.preventDefault()

    message = $(event.target).data('confirm') || $(event.target).parent().data('confirm')

    @model.destroy() if confirm(message)
