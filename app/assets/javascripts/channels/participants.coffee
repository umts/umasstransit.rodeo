App.participants = App.cable.subscriptions.create "ParticipantsChannel",
  connected: ->
  disconnected: ->
  received: (data) ->
    switch data.type
      when 'add'
        console.log({'add': data})
      when 'update'
        console.log({'update': data})
      when 'removed'
        console.log({'removed': data})
