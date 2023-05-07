# rs-ophase
<div align=center>

![GitHub](https://img.shields.io/github/license/whirlpool-galaxy/rs-ophase)
![GitHub tag (latest SemVer pre-release)](https://img.shields.io/github/v/tag/whirlpool-galaxy/rs-ophase?include_prereleases&label=latest%20release)
![rustc](https://img.shields.io/badge/rustc-1.69%2B-blue)
![GitHub repo file count](https://img.shields.io/github/directory-file-count/whirlpool-galaxy/rs-ophase)  
[![Discord](https://img.shields.io/discord/1016731291267387544)](https://discord.gg/T2fDVrmGnF)
![GitHub issues](https://img.shields.io/github/issues/whirlpool-galaxy/rs-ophase)
[![frontend](https://img.shields.io/badge/frontend-yew-brightgreen)](https://crates.io/crates/actix-web)
[![backend](https://img.shields.io/badge/backend-actix--web-brightgreen)](https://crates.io/crates/actix-web)

</div>

## Development

### Database

- [DBeaver Database Tool](https://dbeaver.io/)
- [sqlx-cli](https://crates.io/crates/sqlx-cli) `cargo install sqlx-cli`

### Setup Dev DB

```sql
CREATE OR REPLACE DATABASE <DBNAME> DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL PRIVILEGES ON <DBNAME>.* TO <USER>@"localhost" WITH GRANT OPTION;
```

```bash
export DATABASE_URL=mysql://<USER>:<PASSWD>@localhost/<DBNAME>
sqlx setup
```

## DB-ER

![DB-ER](./doc/assets/db_er_000.png)

## Project Structure

**backend**  
Application backend API

**frontend**  
Application frontend

**common_api**  
Types passed between **backend** and **frontend**

**logic**  
Logic that is used in **backend** and **frontend** or can be used as stand alone application.