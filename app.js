
/**
 * Module dependencies.
 */

var express = require('express')
  , session = require('express-session')
  , morgan = require('morgan')
  , cookieParser = require('cookie-parser')
  , errorHandler = require('errorhandler')
  , http = require('http')
  , path = require('path')
  , passport = require('./server/auth/passport')
  , config = require('./config')
  , router = require('./router');

var app = express();

// all environments
app.set('port', process.env.PORT || 3000);
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');
app.use(morgan());
app.use(express.static(path.join(__dirname, 'public')));
app.use(cookieParser(config.cookie.secret));
app.use(session({
    secret: config.session.secret,
    resave: true,
    saveUninitialized: true
}));
app.use(passport.initialize());
app.use(passport.session());
app.use(router);

// development only
if ('development' == app.get('env')) {
  app.use(errorHandler());
}

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
