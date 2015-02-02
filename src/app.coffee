express = require('express')
app = express()

path = require('path')
favicon = require('static-favicon')
logger = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')

routes = require('./routes')
app.use routes

# view engine setup
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'ejs'

app.use favicon()
app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use cookieParser()
app.use express.static(path.join(__dirname, 'public'))

# error handlers
if (app.get('env') == 'development')
    app.use (err, req, res, next) ->
        res.status err.status || 500
        res.render 'error', {
            message: err.message,
            error: err
        }

app.use (err, req, res, next) ->
    res.status err.status || 500
    res.render 'error', {
        message: err.message,
        error: {}
    }


module.exports = app