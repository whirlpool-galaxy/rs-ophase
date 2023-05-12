mod login;

use actix_web::{web::Data, App, HttpServer};
use login::{login as login_f, logout, Sessions};

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        App::new()
            .app_data(Data::new(Sessions::new()))
            .service(login_f)
            .service(logout)
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}
