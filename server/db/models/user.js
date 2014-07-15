var mongoose = require('../connection');
var Schema = mongoose.Schema;

var userSchema = new Schema({
    uid: {type: String, index: true},
    provider: {type: String, index: true},
    name: String
});

userSchema.index({
    uid: 1,
    provider: 1
});

var User = mongoose.model('User', userSchema);

User.findOrCreate = function (attributes, callback) {
    this.find(attributes, function (err, docs) {
        if (err) return callback(err, null);
        if (docs.length > 0) {
            var user = docs[0];
            callback(null, user);
        } else {
            User.create(attributes, function (err, user) {
                if (err) return callback(err);
                callback(null, user);
            })
        }
    });
};

module.exports = User;
