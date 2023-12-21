import { Controller } from "@hotwired/stimulus"
import debounce from "debounce";

export default class extends Controller {
  static targets = ["filterInput"];

  connect() {
    this.submit = debounce(this.submit.bind(this), 300);
  }

  submit() {
    this.element.requestSubmit();
  }

  filter() {
    this.submit();
  }

  get filterInput() {
    return this.filterInputTarget.value;
  }

  set filterInput(value) {
    this.filterInputTarget.value = value;
  }
}
