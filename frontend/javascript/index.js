import baguetteBox from "baguettebox.js"
import "baguettebox.js/dist/baguetteBox.min.css"
import "$styles/index.css"

document.addEventListener("turbo:load", () => {
  document.querySelectorAll("input[type='checkbox'][disabled]").forEach(item => {
    item.removeAttribute("disabled")
  })
  document.querySelectorAll(".task-list-item").forEach(item => {
    item.addEventListener("click", e => {
      if (e.target.type !== "checkbox") {
        const cb = item.querySelector("input[type='checkbox']")
        if (cb) cb.checked = !cb.checked
      }
    })
  })
  baguetteBox.run(".lightbox")
})
