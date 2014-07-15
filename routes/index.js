
/*
 * GET home page.
 */

exports.index = function (req, res) {
    if (req.user) {
        res.render('index', {name: req.user.name});
    } else {
        res.redirect('/login');
    }
};

exports.login = function (req, res) {
    if (req.user) {
        res.redirect('/');
    } else {
        res.render('login');
    }
};
