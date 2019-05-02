App.manuever_participants = App.cable.subscriptions.create "ManeuverParticipantsChannel",
  connected: ->
  disconnected: ->
  received: (data) ->
    console.log(data)
