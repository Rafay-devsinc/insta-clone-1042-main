# Insta-Clone-1042: Project Overview

## Overview
Insta-Clone-1042 is a Ruby on Rails application that mimics core features of Instagram, including user registration, posts with images, comments, likes, following, and privacy controls. It uses PostgreSQL for the database, Devise for authentication, Pundit for authorization, and Cloudinary for image uploads via ActiveStorage.

---

## Features
- User registration, login, and profile with avatar
- Post images with captions (edit/delete own posts)
- Like/unlike posts
- Comment on posts (edit/delete own comments)
- Follow/unfollow users, with private/public account support
- Search users
- Request/approve followers for private accounts

---

## Prerequisites
- Ruby 2.7.3
- Rails 5.2.8
- PostgreSQL (local or remote)
- Node.js & Yarn (for JS/CSS assets)
- Bundler (`gem install bundler`)

---

## Environment Variables & Credentials
This app uses Rails credentials for sensitive data (Cloudinary, etc.). You need `config/master.key` to decrypt `config/credentials.yml.enc`.

**Required environment variables:**
- `RAILS_MASTER_KEY` (if not using `config/master.key` file)
- `INSTA-CLONE-1042_DATABASE_PASSWORD` (for production DB)

**Cloudinary credentials** (stored in credentials):
- `cloud_name`
- `api_key`
- `api_secret`
- `secure`

**Mailer credentials** (currently hardcoded, but should be set as env vars for security):
- `MAILER_USER_NAME` (Gmail address)
- `MAILER_PASSWORD` (Gmail app password)

---

## .env.example
```
# Rails master key (if not using config/master.key file)
RAILS_MASTER_KEY=your_master_key_here

# Database (production only)
INSTA-CLONE-1042_DATABASE_PASSWORD=your_db_password

# Cloudinary (for reference, actually stored in credentials)
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret
CLOUDINARY_SECURE=true

# Mailer (for reference, currently hardcoded)
MAILER_USER_NAME=your_email@gmail.com
MAILER_PASSWORD=your_gmail_app_password
```

---

## Database Setup
1. Install PostgreSQL and ensure it's running.
2. Create the databases:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

---

## Cloudinary Setup
1. Create a Cloudinary account.
2. Get your `cloud_name`, `api_key`, `api_secret` from the Cloudinary dashboard.
3. Add them to Rails credentials:
   ```bash
   EDITOR="vim" bin/rails credentials:edit
   # Add:
   cloud_name: your_cloud_name
   api_key: your_api_key
   api_secret: your_api_secret
   secure: true
   ```
4. Share `config/master.key` securely with your team (never commit it to git).

---

## Credentials & master.key
- `config/credentials.yml.enc` is encrypted; you need `config/master.key` to decrypt it.
- If you don't have `config/master.key`, ask the project owner for it, or set `RAILS_MASTER_KEY` in your environment.

---

## Running the App Locally
1. Install dependencies:
   ```bash
   bundle install
   yarn install
   ```
2. Setup DB (see above).
3. Ensure `config/master.key` is present (or set `RAILS_MASTER_KEY`).
4. Start the Rails server:
   ```bash
   rails server
   ```
5. Visit [http://localhost:3000](http://localhost:3000)

---

## Testing
- RSpec is used for testing:
  ```bash
  bundle exec rspec
  ```
- System and model tests are in `spec/` and `test/` folders.

---

## Notes
- Do **not** commit `config/master.key` or any real secrets.
- For production, set all secrets in credentials and environment variables.
- Mailer credentials are currently hardcoded for development/production; for security, move them to credentials or ENV.

---
