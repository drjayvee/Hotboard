// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

Turbo.StreamActions.log = function () {
  let method = this.getAttribute('level')
  if (typeof console[method] !== 'function') {
    method = 'log'
  }

  console[method](this.getAttribute("message"))
}

// https://boringrails.com/articles/data-turbo-confirm-beautiful-dialog
Turbo.config.forms.confirm = function (message, element, submitter) {
  const dialog = document.getElementById('turbo-confirm-dialog')

  if (!dialog) return Promise.resolve(confirm(message))

  const messageElement = document.getElementById('turbo-confirm-message')
  const confirmButton = dialog.querySelector('button[type="submit"]')

  // configure dialog
  messageElement.textContent = message
  confirmButton.textContent = submitter?.dataset.turboConfirmButton || "Confirm"

  dialog.showModal()

  return new Promise((resolve) => {
    dialog.addEventListener('close', () => {
      resolve(dialog.returnValue === 'confirm')
    }, { once: true })
  })
}
