import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "modal", "title", "description", "amount", "category", "date", "kind" ]
  static values = { 
    title: String,
    category: String,
    amount: String,
    kind: String,
    kindClass: String,
    description: String,
    date: String
  }

  open(event) {
    this.titleTarget.textContent = event.params.title
    this.descriptionTarget.textContent = event.params.description
    this.amountTarget.textContent = event.params.amount
    this.categoryTarget.textContent = event.params.category
    this.dateTarget.textContent = event.params.date
    this.kindTarget.textContent = event.params.kind
    this.kindTarget.className = `${event.params.kindClass} py-1 px-3 rounded-full text-xs`

    this.modalTarget.classList.remove("hidden")
  }

  close() {
    this.modalTarget.classList.add("hidden")
  }
}