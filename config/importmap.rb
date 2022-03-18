# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "https://unpkg.com/@hotwired/turbo-rails@7.1.1/app/assets/javascripts/turbo.js",
                             preload: true
pin "alpinejs", to: "https://unpkg.com/alpinejs@3.9.1/dist/module.esm.js", preload: true
pin "alpine-turbo-drive-adapter",
    to: "https://unpkg.com/alpine-turbo-drive-adapter@2.0.0/dist/alpine-turbo-drive-adapter.esm.js", preload: true
pin_all_from "app/javascript/modules", under: "modules"
