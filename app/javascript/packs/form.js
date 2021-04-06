const needPage = function() {
  let askButton = document.querySelector('#ask-button')

  if(!askButton) {
    return
  } else {
    const toggleForm = function(e) {
      e.preventDefault()
      let askForm = document.querySelector('#ask-form')
      askForm.classList.toggle('user-question-form-div')
    }
    askButton.addEventListener('click', toggleForm)
  }
}

document.addEventListener('DOMContentLoaded', needPage)
