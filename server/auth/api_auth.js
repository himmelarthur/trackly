module.exports = function (req, res, next) {
    if (req.params.user_id && (!req.user || req.user._id != req.params.user_id)) {
        res.status(403).send('Unauthorized');
    } else {
        next();
    }
};