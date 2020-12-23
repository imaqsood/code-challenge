import { Controller } from "stimulus";

export default class extends Controller {

  static targets = [ "colorWell", "colorElement" ]

  connect() {
    let colorWell = this.colorWellTarget;
    this.csrfToken = document.querySelector("[name='csrf-token']").content
    this.changeBackground(colorWell.value)
    colorWell.addEventListener("input", (event) => this.changeBackground(event.target.value), false);
    colorWell.addEventListener("change", (event) => this.update(event.target.value), false);
    colorWell.select();
  }

  changeBackground(color) {
    this.colorElementTargets.forEach( (t) =>
      t.style.setProperty("background-color", color, "important")
    );
  }

  update(color) {
    let options = {
      method: 'PUT',
      headers: {
        "X-CSRF-Token": this.csrfToken,
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ company: { brand_color: color }})
    };
    fetch(window.location.pathname+'.json', options);
  }
}
