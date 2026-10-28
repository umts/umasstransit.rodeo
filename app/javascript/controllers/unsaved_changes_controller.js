import { Controller } from "@hotwired/stimulus";

const DEFAULT_MESSAGE = "You have unsaved changes. Leave this page?";

export default class extends Controller {
  static values = { message: String };

  connect() {
    this.dirty = false;
    this.onChange = () => this.markDirty();
    this.onSubmit = (event) => {
      // Deferred so that any other listener on this same submit event
      // (e.g. form-confirm's intercept(), which calls preventDefault() to
      // pause for a confirmation dialog) has already run by the time this
      // checks defaultPrevented, regardless of listener registration order.
      queueMicrotask(() => {
        if (!event.defaultPrevented) this.markClean();
      });
    };
    this.onBeforeUnload = (event) => {
      if (!this.dirty) return;
      event.preventDefault();
    };
    this.onBeforeVisit = (event) => {
      if (!this.dirty || event.defaultPrevented) return;
      if (!window.confirm(this.messageValue || DEFAULT_MESSAGE)) {
        event.preventDefault();
      }
    };

    this.element.addEventListener("input", this.onChange);
    this.element.addEventListener("change", this.onChange);
    this.element.addEventListener("submit", this.onSubmit);
    window.addEventListener("beforeunload", this.onBeforeUnload);
    document.addEventListener("turbo:before-visit", this.onBeforeVisit);
  }

  disconnect() {
    this.element.removeEventListener("input", this.onChange);
    this.element.removeEventListener("change", this.onChange);
    this.element.removeEventListener("submit", this.onSubmit);
    window.removeEventListener("beforeunload", this.onBeforeUnload);
    document.removeEventListener("turbo:before-visit", this.onBeforeVisit);
  }

  markDirty() {
    this.dirty = true;
  }

  markClean() {
    this.dirty = false;
  }
}
