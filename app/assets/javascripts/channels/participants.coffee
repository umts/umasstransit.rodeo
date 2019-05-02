App.participants = App.cable.subscriptions.create "ParticipantsChannel",
  connected: ->
    console.log('connected!')

  disconnected: ->
    console.log('disconnected!')

  received: (data) ->
    console.log(data)
