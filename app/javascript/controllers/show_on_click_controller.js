import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['hiddenChat', 'hiddenCall'];
  connect() {
    this.hiddenChatTarget.style.display = "none"
    this.hiddenChat = true
    this.hiddenCallTarget.style.display = "none"
    this.hiddenCall = true
  }
  toggleChat() {
    this.hiddenChatTarget.style.display = this.hiddenChat ? "contents" : "none"
    this.hiddenChat = !this.hiddenChat
    const counter = document.querySelector("#counter");
    if (counter) {counter.remove()};
  }
  toggleCall() {
    this.hiddenCallTarget.style.display = this.hiddenCall ? "contents" : "none"
    this.hiddenCall = !this.hiddenCall
  }
}
