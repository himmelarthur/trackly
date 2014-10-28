var apiRoutes = require('../routes/api');
var apiAuth = require('./auth/api_auth');

module.exports = function (router) {

    router.get('/api/user/:user_id/tracks', apiRoutes.tracks.get);

    router.post('/api/user/:user_id/tracks', apiAuth, apiRoutes.tracks.post);

    router.delete('/api/user/:user_id/tracks/:track_id', apiAuth, apiRoutes.tracks.delete);

};
