import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "modal" ]

    // hide modal on successful form submission
  // data-action="turbo:submit-end->turbo-modal#submitEnd"
  submitEnd(e) {
    if (e.detail.success) {
      // console.log(e.detail.success)
      this.modalTarget.close()
    }
  }

  open() {
    this.modalTarget.showModal();
    document.body.classList.add("overflow-hidden");
  }

  clickOutside(event) {
    if (event.target === this.modalTarget) {
      this.modalTarget.close()
    }
  }

}