import "@hotwired/turbo-rails"

document.addEventListener("turbo:load", () => {
  const uploadField = document.querySelector(".upload")
  const imageFrame = document.querySelector(".image-frame")

  if (!uploadField || !imageFrame) {
    return
  }

  uploadField.addEventListener("change", event => {
    const image = event.target.files && event.target.files[0]

    if (!image) {
      imageFrame.innerHTML = ""
      return
    }

    const reader = new FileReader()
    reader.onload = file => {
      const img = new Image()

      img.src = file.target.result
      img.alt = "Recipe preview"
      imageFrame.innerHTML = ""
      imageFrame.appendChild(img)
    }

    reader.readAsDataURL(image)
  })
})
