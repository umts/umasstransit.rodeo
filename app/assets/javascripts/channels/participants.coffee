App.participants = App.cable.subscriptions.create "ParticipantsChannel",
  connected: ->
  disconnected: ->
  received: (data) ->
    switch data.type
      when 'add'
      when 'update'
      when 'removed'
