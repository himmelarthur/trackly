var passport = require('passport');
var facebookStrategy = require('./facebook_auth');

passport.serializeUser(function (user, done) {
    done(null, user);
});

passport.deserializeUser(function (user, done) {
    done(null, user);
})

passport.use(facebookStrategy);

module.exports = passport;