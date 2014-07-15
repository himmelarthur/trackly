var express = require('express')
    , routes = require('./routes')
    , passport = require('./server/auth/passport');

var router = express.Router();

// PAGES
router.get('/', routes.index);
router.get('/login', routes.login);

// AUTH
router.get('/auth/facebook', passport.authenticate('facebook'));
router.get('/auth/facebook/callback', passport.authenticate('facebook', {
    successRedirect: '/',
    failureRedirect: '/'
}));

module.exports = router;