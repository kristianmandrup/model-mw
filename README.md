# Model Middleware

Mode middleware

## Goal

Should hook together all the middleware required to:

 * save a model to the server/DB
 * read a model from the server DB and expose it to the client (fx Angular or similar UI framework)

 ## Dependencies

validator-mw, authorize-mw and perhaps later authenticate-mw

 ## TODO

 Add validator-mw, authorize-mw etc. as described on Gist (also see model_config) in middleware project.
 Should be something similar (but not exactly - is just pseudo code/thoughts for now).

 Move simple_mw + test from middleware here instead of model_mw