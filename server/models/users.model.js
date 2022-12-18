const mongoose = require("mongoose");
const { productSchema } = require("./product.model");

const userSchema = new mongoose.Schema({
    name:{
        type: String,
        required: true
    },
    phone:{
        type: String,
        required: true
    },
    address:[{
        type: mongoose.Schema.Types.ObjectId,
        ref:'Address',
        required: true
    }],
    // orderHistory:{
        
    // },
    email:{
        type: String,
        required: true
    },
    orderHistory:[{
        type: mongoose.Schema.Types.ObjectId,
        ref:'Order',
    }],
    cart: [
        {
          product: productSchema,
          quantity: {
            type: Number,
            required: true, 
          },
        },
      ],
});

exports.User = mongoose.model('User', userSchema);