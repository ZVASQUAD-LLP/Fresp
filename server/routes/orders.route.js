const {User}= require('../models/users.model');
const {Order} = require('../models/orders.model');
const express = require('express');
const { OrderItem } = require('../models/order-item.model');
const crypto = require("crypto");
const Razorpay = require('razorpay');
const { stringify } = require('querystring');
const router = express.Router();
const hash = require("hashcode").hashCode;
const auth = require('../middlewares/auth.middleware');

//environment variables
const razorpay_key = process.env.Razorpay_key;
const razorpay_secret = process.env.Razorpay_secret;
//razorpay init
const razorpayInstance = new Razorpay({
	key_id: razorpay_key,
	key_secret: razorpay_secret
});

router.get(`/`, async (req, res) =>{
    const orderList = await Order.find().populate('user', 'name').sort({'dateOrdered': -1});

    if(!orderList) {
        res.status(500).json({success: false})
    } 
    res.send(orderList);
})

router.get(`/:id`, async (req, res) =>{
    console.log(req.params.id);
    const order = await Order.findById(req.params.id)
    .populate('user', 'name')
    .populate({ 
        path: 'orderItems', populate: {
            path : 'product', populate: 'category'} 
        });

    if(!order) {
        res.status(500).json({success: false})
    } 
    res.send({"orderId" : order._id, "totalPrice" : order.totalPrice});
})

router.post('/',auth, async (req,res)=>{
   
    const orderItemsIds = Promise.all(req.body.orderItems.map(async (orderItem) =>{
        let newOrderItem = new OrderItem({
            quantity: orderItem.quantity,
            product: orderItem.product._id
        })

        newOrderItem = await newOrderItem.save();

        return newOrderItem._id;
    }))
    const orderItemsIdsResolved =  await orderItemsIds;

    const totalPrices = await Promise.all(orderItemsIdsResolved.map(async (orderItemId)=>{
        const orderItem = await OrderItem.findById(orderItemId).populate('product', 'price');
        const totalPrice = orderItem.product.price * orderItem.quantity;
        return totalPrice
    }))

    const totalPrice = totalPrices.reduce((a,b) => a +b , 0);

    let order = new Order({
        orderItems: orderItemsIdsResolved,
        shippingAddress: req.body.addressId,
        phone: req.body.phone,
        totalPrice: totalPrice,
        user: req.body.user,
    })
    order = await order.save().then(async(order)=>{
        const orderDetails = {
            amount : totalPrice*100,
            currency : "INR",
            receipt : crypto.createHash('md5').update(stringify(order._id).concat(Date.now)).digest('hex'),
        }
        await razorpayInstance.orders.create((orderDetails),
        async (err, orderRes)=>{
            if(!err){
                
                order.order_id = orderRes.id;
                order = await order.save();
                let user = await User.findOne({email: req.email});
                
                user.orderHistory.push(order._id);
                user = await user.save();
                res.send(orderRes.id);
            }
            else{
                res.send(err);
            }
        })
    });
    
    
        
})


router.put('/:id',async (req, res)=> {
    const order = await Order.findByIdAndUpdate(
        req.params.id,
        {
            status: req.body.status
        },
        { new: true}
    )

    if(!order)
    return res.status(400).send('the order cannot be update!')

    res.send(order);
})


router.delete('/:id', (req, res)=>{
    Order.findByIdAndRemove(req.params.id).then(async order =>{
        if(order) {
            await order.orderItems.map(async orderItem => {
                await OrderItem.findByIdAndRemove(orderItem)
            })
            return res.status(200).json({success: true, message: 'the order is deleted!'})
        } else {
            return res.status(404).json({success: false , message: "order not found!"})
        }
    }).catch(err=>{
       return res.status(500).json({success: false, error: err}) 
    })
})

router.get('/get/totalsales', async (req, res)=> {
    const totalSales= await Order.aggregate([
        { $group: { _id: null , totalsales : { $sum : '$totalPrice'}}}
    ])

    if(!totalSales) {
        return res.status(400).send('The order sales cannot be generated')
    }

    res.send({totalsales: totalSales.pop().totalsales})
})

router.get(`/get/count`, async (req, res) =>{
    const orderCount = await Order.countDocuments((count) => count)

    if(!orderCount) {
        res.status(500).json({success: false})
    } 
    res.send({
        orderCount: orderCount
    });
})

router.get(`/get/userorders/:userid`, async (req, res) =>{
    const userOrderList = await Order.find({user: req.params.userid}).populate({ 
        path: 'orderItems', populate: {
            path : 'product', populate: 'category'} 
        }).sort({'dateOrdered': -1});

    if(!userOrderList) {
        res.status(500).json({success: false})
    } 
    res.send(userOrderList);
})



module.exports = router;