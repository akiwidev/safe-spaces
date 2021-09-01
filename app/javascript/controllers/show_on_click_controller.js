import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['hiddenElement'];
  connect() {
    this.hiddenElementTarget.style.display = "none"
    this.hidden = true
  }
  toggle() {
    this.hiddenElementTarget.style.display = this.hidden ? "contents" : "none"
    this.hidden = !this.hidden
    const counter = document.querySelector("#counter");
    if (counter) {counter.remove()};
  }
}
