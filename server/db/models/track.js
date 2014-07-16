var mongoose = require('../connection');
var Schema = mongoose.Schema;

var trackSchema = new Schema({
    userId: {type: String, index: true},
    name: String,
    url: String,
    provider: String
});

trackSchema.index({
    userId: 1
});

var Track = module.exports = mongoose.model('Track', trackSchema);
