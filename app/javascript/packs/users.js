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
//изменение цвета шапки, можно сделать реактивно потом
// document.addEventListener('DOMContentLoaded', needPage)

// const changeHeaderColor = function() {
//   let inputColor = document.querySelector('#header_color')

//   if(!inputColor) {
//     return
//   } else {
//     inputColor.addEventListener('input', function() {
//       document.querySelector('.user-header').style.background = inputColor.value
//     })
//   }
// }

// document.addEventListener('DOMContentLoaded', changeHeaderColor)
