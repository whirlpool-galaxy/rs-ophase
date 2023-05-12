/*
 * Copyright (C) 2023 Jonathan "Nath" Schild - MIT License
 */

// TODOC
use std::{collections::HashMap, sync::Mutex};

use actix_web::{
    cookie::{Cookie, CookieBuilder},
    delete, post,
    web::{Data, Json},
    HttpRequest, HttpResponse, Responder,
};

use serde::Deserialize;
use uuid::Uuid;

#[derive(Debug, Default)]
pub struct SessionData;

// TODO sql as persistence layer?
#[derive(Debug)]
pub struct Sessions {
    session_data: Mutex<HashMap<Uuid, SessionData>>,
}

impl Sessions {
    pub fn new() -> Self {
        Sessions {
            session_data: Mutex::new(HashMap::new()),
        }
    }

    fn create(&self) -> Uuid {
        let uuid = Uuid::new_v4();
        let mut mux = self.session_data.lock().unwrap(); // TODO error handling
        mux.insert(uuid, SessionData::default());
        uuid
    }

    fn destroy(&self, sid: &Uuid) {
        let mut mux = self.session_data.lock().unwrap(); // TODO error handling
        mux.remove(sid);
    }

    pub fn get_sid(cookie: &Cookie) -> Option<Uuid> {
        match Uuid::parse_str(cookie.value()) {
            Ok(uuid) => Some(uuid),
            Err(_) => None,
        }
    }
}

#[derive(Deserialize, Debug)]
pub struct Credentials {
    name: String,
    password: String,
}

#[post("/login")]
pub async fn login(
    session: Data<Sessions>,
    credentials: Json<Credentials>,
    cookies: HttpRequest,
) -> impl Responder {
    // TODO session cookie as config option

    // if session id exists => no need to log in
    if cookies.cookie("sid").is_some() {
        HttpResponse::Ok().finish()
    } else
    // XXX
    if credentials.name == "admin" && credentials.password == "admin" {
        // XXX secure cookie settings
        let uuid = session.create().hyphenated().to_string();
        let cookie = CookieBuilder::new("sid", uuid.as_str()).finish();
        HttpResponse::Ok().cookie(cookie).finish()
    } else {
        HttpResponse::Unauthorized().finish()
    }
}

#[delete("/logout")]
pub async fn logout(session: Data<Sessions>, cookies: HttpRequest) -> impl Responder {
    // TODO session cookie as config option
    match cookies.cookie("sid") {
        Some(mut c) => {
            if let Some(sid) = Sessions::get_sid(&c) {
                session.into_inner().destroy(&sid);
                c.make_removal();
                HttpResponse::Ok().cookie(c).finish()
            } else {
                HttpResponse::Ok().finish()
            }
        }
        _ => HttpResponse::Ok().finish(),
    }
}
