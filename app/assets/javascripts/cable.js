// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the rails generate channel command.
//
// = require actioncable
// = require_self
// = require_tree ./channels

// oxlint-disable-next-line no-unused-expressions
window.App || (window.App = {});
App.cable = ActionCable.createConsumer();
