import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "modal" ]

  open() {
    this.modalTarget.classList.add("is-active")
  }

  close() {
    this.modalTarget.classList.remove("is-active")
  }
}
