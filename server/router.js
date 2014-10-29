var express = require('express'),
    routes = require('../routes/index'),
    passport = require('./auth/passport');

var registerApi = require('./api');

var Track = require('./db/models/track');

var router = express.Router();

// PAGES
router.get('/', function (req, res, next) {
    if (req.user) {
        res.locals.expose = {};
        res.locals.expose.user = req.user;
        Track.getTracksForUserId(req.user._id, function (err, data) {
            if (err) {
                res.send(err);
            } else {
                res.locals.expose.tracks = data;
                next();
            }
        });
    } else {
        next();
    }
}, routes.index);

router.get('/login', routes.login);

// AUTH
router.get('/auth/facebook', passport.authenticate('facebook', {scope: 'publish_actions'}));
router.get('/auth/facebook/callback', passport.authenticate('facebook', {
    successRedirect: '/',
    failureRedirect: '/'
}));
router.get('/logout', function (req, res) {
    req.logout();
    res.redirect('/');
});

registerApi(router);

// API

module.exports = router;