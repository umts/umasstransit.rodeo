// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the rails generate channel command.
//
// = require actioncable
// = require_self
// = require_tree ./channels

window.App || (window.App = {});
App.cable = ActionCable.createConsumer();
