import { Controller } from "stimulus";

export default class extends Controller {

  static targets = ["error"]

  connect() {
    this.errorTarget.style.display = 'none'
  }

  validate(event) {
    let message = []
    let email = event.target.value
    if (!email.legth){ return email }

    if(!email.endsWith('@getmainstreet.com')) {
      message.push("email must end with @getmainstreet.com")
    }

    if(!/^[0-9a-z._-]+@[0-9a-z._-]+$/i.test(email)){
      message.push("email can only contains (0 to 9, a to z, ., _, -) characters")
    }

    if(message.length) {
      this.errorTarget.innerHTML = message.join(', ')
      this.errorTarget.style.display = 'block'
    }
    else{
      this.errorTarget.innerHTML = ''
      this.errorTarget.style.display = 'none'
    }
  }
}
