var apiRoutes = require('../routes/api');

module.exports = function (router) {

    router.get('/api/user/:user_id/tracks', apiRoutes.tracks.get);

    router.post('/api/user/:user_id/tracks', apiRoutes.tracks.post);

    router.delete('/api/user/:user_id/tracks/:track_id', apiRoutes.tracks.delete);

};
