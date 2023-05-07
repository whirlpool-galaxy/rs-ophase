# rs-ophase
<div align=center>

![GitHub](https://img.shields.io/github/license/whirlpool-galaxy/rs-ophase)
![GitHub tag (latest SemVer pre-release)](https://img.shields.io/github/v/tag/whirlpool-galaxy/rs-ophase?include_prereleases&label=latest%20release)
![rustc](https://img.shields.io/badge/rustc-1.69%2B-blue)
![GitHub repo file count](https://img.shields.io/github/directory-file-count/whirlpool-galaxy/rs-ophase)  
[![Discord](https://img.shields.io/discord/1016731291267387544)](https://discord.gg/T2fDVrmGnF)
[![GitHub issues](https://img.shields.io/github/issues/whirlpool-galaxy/rs-ophase)](https://github.com/whirlpool-galaxy/rs-ophase/issues/new)
[![frontend](https://img.shields.io/badge/frontend-yew-brightgreen)](https://crates.io/crates/actix-web)
[![backend](https://img.shields.io/badge/backend-actix--web-brightgreen)](https://crates.io/crates/actix-web)

</div>

## Development

Create a `./.env` File:

    DATABASE_URL="mysql://<USER>:<PASSWD>@localhost/<DBNAME>"

Install [rust-lang](https://www.rust-lang.org/learn/get-started):

`curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

### Database

- [DBeaver Database Tool](https://dbeaver.io/)
- [sqlx-cli](https://crates.io/crates/sqlx-cli) `cargo install sqlx-cli`

### Setup Dev DB

```sql
CREATE OR REPLACE DATABASE <DBNAME> DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL PRIVILEGES ON <DBNAME>.* TO <USER>@"localhost" WITH GRANT OPTION;
```

```bash
# export DATABASE_URL=mysql://<USER>:<PASSWD>@localhost/<DBNAME>
# or use .env file
sqlx setup
```

## DB-ER

![DB-ER](./doc/assets/db_er_000.png)

