var FacebookStrategy = require('passport-facebook').Strategy;
var User = require('../db/models/user');

var config = require('../../config');

module.exports = new FacebookStrategy({
    clientID: config.facebook.appID,
    clientSecret: config.facebook.appSecret,
    callbackURL: config.facebook.callbackURL
}, function (accessToken, refreshToken, profile, done) {
    User.findOrCreate({
        uid: profile.id,
        provider: profile.provider,
        name: profile.displayName
    }, function (err, user) {
        if (err) {
            return done(err);
        }
        done(null, user);
    });
})
