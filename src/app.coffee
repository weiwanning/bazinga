express = require('express')
app = express()

path = require('path')
favicon = require('static-favicon')
logger = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')

routes = require('./routes')

# view engine setup
app.set 'views', path.join(__dirname, '/views')
app.engine 'html', require('ejs').renderFile
app.set 'view engine', 'html'

app.use favicon()
app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use cookieParser()
app.use express.static(path.join(__dirname, '/public'))

app.use routes

# error handlers
if (app.get('env') == 'development')
    app.use (err, req, res, next) ->
        res.status err.status || 500
        res.json {
            message: err.message,
            error: {}
        }

app.use (err, req, res, next) ->
    res.status err.status || 500
    res.json {
        message: err.message,
        error: {}
    }


module.exports = app