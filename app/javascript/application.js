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
