import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modals"
export default class extends Controller {
  connect() {
  }
  submitEnd(e) {
    console.log(e.detail);
  }
  close(e) {
    e.preventDefault();
    const modal = document.getElementById("modal");
    modal.innerHTML = "";
    modal.removeAttribute("src");
    modal.removeAttribute("complete");
  }

  hideModal() {
    this.element.remove();
  }
}
