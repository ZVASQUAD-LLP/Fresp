const mongoose = require("mongoose");

const loginCredentialSchema = new mongoose.Schema({
    email:{
        type:String,
        required:true
    },
    passwordHash:{
        type: String,
        required: true
    },
    isAdmin:{
        type: Boolean,
        default: false,
        
    }
});

exports.loginCredential = mongoose.model('loginCredential', loginCredentialSchema); 