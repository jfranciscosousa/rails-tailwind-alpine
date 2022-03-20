# rails-tailwind-alpine

A Rails starter where I minimize context switching by using `tailwind` and `alpine` trying to keep almost everything in my `HTML`.

It also ships with:
- `view_component`
- `sorcery`
  - email/password auth
  - password reset
  - a secured resource `Todo` as an example
- `rspec` and some sample tests
- `daisy-ui` for some Tailwind base styles

## Requirements

- `node`
- `ruby-3.1.0`
- `postgres`

## Setup

Make sure you have a `postgres` database available on `localhost:5432`. After that you just need to run `bin/setup`.

## Development

Just run `bin/dev` and you can check out your site at `localhost:5000`.

