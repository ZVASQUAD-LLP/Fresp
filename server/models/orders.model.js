const mongoose = require('mongoose');

const orderSchema = mongoose.Schema({
    orderItems: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'OrderItem',
        required:true
    }],
    shippingAddress:{
        type: mongoose.Schema.Types.ObjectId,
        ref:'Address'
    },
    phone: {
        type: String,
        required: true,
    },
    totalPrice: {
        type: Number,
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
    },
    dateOrdered: {
        type: Date,
        default: Date.now,
    },
    order_id:{
        type: String,
        default: ""
    },
    // payment_id:{
    //     type: String
    // },
    // receipt:{
    //     type: String
    // }
})



exports.Order = mongoose.model('Order', orderSchema);
// /**
// Order Example:

// {
//     "orderItems" : [
//         {
//             "quantity": 3,
//             "product" : "5fcfc406ae79b0a6a90d2585"
//         },
//         {
//             "quantity": 2,
//             "product" : "5fd293c7d3abe7295b1403c4"
//         }
//     ],
//     "shippingAddress1" : "Flowers Street , 45",
//     "shippingAddress2" : "1-B",
//     "city": "Prague",
//     "zip": "00000",
//     "country": "Czech Republic",
//     "phone": "+420702241333",
//     "user": "5fd51bc7e39ba856244a3b44"
// }

//  */