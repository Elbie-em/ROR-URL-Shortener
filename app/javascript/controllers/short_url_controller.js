// short_url_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "result", "shortUrl", "copyButton"];
  static actions = [["click->copyButton->copyShortUrl"]];

  connect() {
    this.formTarget.addEventListener("turbo:submit-end", (event) =>
      this.handleSubmit(event)
    );
  }

  async handleSubmit(event) {
    if (event.detail.success) {
      await this.handleSuccess(event);
    } else {
      await this.handleError(event);
    }
  }

  async handleSuccess(event) {
    const response = event.detail.fetchResponse.response;
    const data = await response.json();
    const shortUrl = `${window.location.origin}/${data.short_code}`;
    this.shortUrlTarget.href = shortUrl;
    this.shortUrlTarget.textContent = shortUrl;
    this.resultTarget.style.display = "block";
  }

  async handleError(event) {
    const response = event.detail.fetchResponse.response;
    const data = await response.json();
    alert(`Error: ${JSON.stringify(data.errors)}`);
  }

  copyShortUrl(event) {
    event.preventDefault();

    const el = document.createElement("textarea");
    el.value = this.shortUrlTarget.textContent;
    document.body.appendChild(el);
    el.select();
    document.execCommand("copy");
    document.body.removeChild(el);

    // Optional: Show a message that the URL has been copied
    alert("Short URL copied to clipboard!");
  }
}
