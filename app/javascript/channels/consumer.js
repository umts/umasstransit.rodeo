// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `bin/rails generate channel` command.

import { createConsumer } from "@rails/actioncable";

const cableUrl = document.querySelector("meta[name='action-cable-url']");

export default cableUrl ? createConsumer(cableUrl.content) : null;
