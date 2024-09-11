import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash-hide"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.dismiss()
    }, 2000)
  }

  dismiss() {
    this.element.remove()
  }
}