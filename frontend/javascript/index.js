import "@hotwired/turbo"
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
  baguetteBox.run(".lightbox", {
    afterShow: () => {
      const overlay = document.getElementById("baguetteBox-overlay")
      if (!overlay || overlay.dataset.touchDismiss) return
      overlay.dataset.touchDismiss = "1"
      let startX, startY
      overlay.addEventListener("touchstart", e => {
        startX = e.changedTouches[0].pageX
        startY = e.changedTouches[0].pageY
      }, { passive: true })
      // baguetteBox's touchmoveHandler calls preventDefault() before checking
      // movement thresholds, which cancels synthetic click events on mobile.
      // Catch taps here on touchend instead and drive close directly.
      overlay.addEventListener("touchend", e => {
        const dx = Math.abs(e.changedTouches[0].pageX - startX)
        const dy = Math.abs(e.changedTouches[0].pageY - startY)
        if (dx < 20 && dy < 20) {
          e.preventDefault() // suppress the now-redundant synthetic click
          document.getElementById("close-button")?.click()
        }
      }, { passive: false })
    }
  })
})
