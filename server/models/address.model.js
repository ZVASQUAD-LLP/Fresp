const mongoose = require("mongoose");

const addressSchema = new mongoose.Schema({
    street: {
        type: String,
        default: '',
        // required: true
    },
    apartment: {
        type: String,
        default: '',
        // required: true
    },
    zip :{
        type: String,
        default: '',
        // required: true
    },
    city: {
        type: String,
        default: '',
        // required: true
    },
});

exports.Address = mongoose.model('Address', addressSchema);
 