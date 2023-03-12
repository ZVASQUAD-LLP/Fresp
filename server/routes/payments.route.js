const express = require("express");
const crypto = require("crypto");
const Razorpay = require('razorpay')
const app = express();
const router = express.Router();
//middleware

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.set("view engine", "ejs");
//environment variables
const razorpay_key = process.env.Razorpay_key;
const razorpay_secret = process.env.Razorpay_secret;

//razorpay init
const razorpayInstance = new Razorpay({
	key_id: razorpay_key,
	key_secret: razorpay_secret
});
let orderRes;
router.post("/createOrder", (req,res)=>{
        const {amount,currency,receipt, notes}  = req.body;  
        razorpayInstance.orders.create({amount, currency, receipt, notes}, 
            (err, order)=>{
              if(!err){
                orderRes = order;
                res.json(order)
              }
              else
                res.send(err);
            }
        )
});
router.post("/checkout", (req,res)=>{
    res.render("index", {order: req.body.order_id, key: razorpay_key})
  })
//to-do *VERIFY PAYMENT*
//   app.post("/verify", (req,res)=>{
//     console.log(req.body);
//   })

module.exports = router; 