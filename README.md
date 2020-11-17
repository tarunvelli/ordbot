<div align="center">
  <br>
  <h1>Ordbot</h1>
  <strong>SAAS Project that enables small to medium vendors to sell via WhatsApp</strong>
  <br>
  <br>

  ![](./app/assets/images/OrdBot.gif)
</div>

# Installation

## Prerequisites

### Local

- [Ruby](https://www.ruby-lang.org/en/): we recommend using
  [rvm](https://rvm.io/) to manage the Ruby versions. Install the requried ruby version with rvm.  `rvm install 2.6.5`
- [Yarn](https://yarnpkg.com/) 1.x: please refer to their
  [installation guide](https://classic.yarnpkg.com/en/docs/install).
- [PostgreSQL](https://www.postgresql.org/) 11 or higher.


### Production
- Local setup +
- [Redis](https://redis.io/) 4 or higher.
- [Elasticsearch](https://www.elastic.co) 7 or higher.

## Steps

- Clone repository

```
git clone https://github.com/tarunvelli/ordbot.git
```

- Change into into repo directory

```
cd ordbot
```

- Install gems

```
bundle install
```

- Install node_modules

```
yarn install
```

- Add .env file (can copy .env_sample) and add required values

  - To generate keys for ACCOUNT_SID_ENCRYPTION_KEY and AUTH_TOEKN_ENCRYPTION_KEY run the following in rails console and copy to .env
  ```
  `rake secret\`[0..31]
  ```

  - To generate keys for CIPHER_KEY run the following in rails console and copy to .env
  ```
  len   = ActiveSupport::MessageEncryptor.key_len
  salt  = SecureRandom.random_bytes(len)
  key   = ActiveSupport::KeyGenerator.new('<some_password>').generate_key(salt, len)
  Base64.encode64(key)
  ```

- Run the server
```
rails server
```

- The app will be available at http://localhost:3000