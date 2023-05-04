import { Application } from "@hotwired/stimulus";
import ShortUrlController from "./controllers/short_url_controller";
import "@hotwired/turbo-rails";
import * as ActiveStorage from "@rails/activestorage";

ActiveStorage.start();

const application = Application.start();
application.register("short-url", ShortUrlController);
