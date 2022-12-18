const {loginCredential} = require('../models/loginCredential.model');
const {Address}= require("../models/address.model");
const {User} = require("../models/users.model");
const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { json } = require('express');
const auth = require('../middlewares/auth.middleware');
const {Product} = require ("../models/product.model");

router.post('/', async(req, res)=>{
    let checkUser =await User.findOne({email: req.body.email});
    if(checkUser){
        return res.send("email already exists")
    }
    let login = new loginCredential({
        email : req.body.email,
        passwordHash: bcrypt.hashSync(req.body.password, 10) 
    })
    login = await login.save()
    let user = new User({
        name: req.body.name,
        phone: req.body.number,
        email: req.body.email
    });
    user =await  user.save();
    if(!user)
    return res.status(400).send('the user cannot be posted!')
    res.send(user);
})
router.get('/getUser', auth , async(req,res)=>{
    try{
        
        const userLoginDetail = await loginCredential.findById(req.user);
        const user = await User.findOne({'email': userLoginDetail.email});
       
        const userObj ={
            email: user.email,
            token: req.token,
            isAdmin: userLoginDetail.isAdmin
        }
       
        res.json(userObj);
    }catch(e){
        res.status(500).json({error : e.message});
    }
   }
)
router.get('/', auth , async(req,res)=>{
    try{
        
        const userLoginDetail = await loginCredential.findById(req.user);
        const user = await User.findOne({'email': userLoginDetail.email});
        
        res.json(user);
    }catch(e){
        res.status(500).json({error : e.message});
    }
   }
)
router.put('/:id', async(req, res)=>{
    let user = User.findByIdAndUpdate(
        req.params.id,
        {
            name: req.body.name,
            phone: req.body.number,
            email: req.body.email
        },
        {new: true}
        )
        if(!product){
            return res.status(500).send('the product cannot be updated!')
        }
        res.send(user);
})
router.post('/login', async (req,res) => {
 
    const user = await loginCredential.findOne({email: req.body.email})
    
    const secret = process.env.SECRET;
    if(!user) { 
        return res.status(400).send('The user not found');
    }

    if(user && bcrypt.compareSync(req.body.password, user.passwordHash)) {
        const token = jwt.sign(
            {
                email: user.email,
                userId: user._id,
                isAdmin: user.isAdmin
            },
            secret,
            {expiresIn : '1d'}
        )
       
        res.status(200).send({email: user.email , token: token, isAdmin:user.isAdmin}) 
    } else {
       res.status(400).send('password is wrong!');
    }
})
router.post('/tokenIsValid', async (req,res) => {
    
    try{
        const token = req.header('x-auth-token');
       
        if(!token)
            return res.json(false);
        const isVerified = jwt.verify(token, process.env.SECRET );
        if(!isVerified)
            return res.json(false);
        const user = await loginCredential.findById(isVerified.userId);
      
        if(!user)
            return res.json(false)
        res.json(true);            
    }catch(e){
        res.status(500).json({error : e.message}); 
    }
})
router.post("/address",auth, async(req, res)=>{
    let address = new Address({
        street: req.body.street,
        apartment: req.body.apartment,
        zip: req.body.zip,
        city: req.body.city,
     
    });
    address = await address.save(); 
   
    let addressUpdate = await User.findOne({email: req.email});
    
    addressUpdate.address.push(address);
    addressUpdate = await addressUpdate.save()
    .then((addressRes)=>{return res.send(addressRes)})
    .catch((err)=>{return res.status(400).send('the user address cannot be updated')});
}) 
router.get("/address/", auth, async(req,res)=>{
    try{
        const id = req.params.id;
        const user = await User.findOne({email: req.email}).populate('address');
        const UserAddress= user.address;
        res.send(UserAddress);
    }catch(e){
        res.status(500).json({error: e.message})
    }
})
router.put("/address/:id", async(req,res)=>{
    let address = Address.findByIdAndUpdate(
        req.params.id,
        {
            street: req.body.street,
            apartment: req.body.apt,
            zip: req.body.zip,
            city: req.body.city,
            country: req.body.country
        },
        {new: true}
    );
    if(!address)
    return res.status(500).send('the address cannot be updated!')

    res.send(address);
})
router.delete("/address/:id", async (req,res)=>{
    const auth= req.headers.authorization;
    const token = auth.split(' ');
    const userEmail = jwt.verify(token[1], process.env.SECRET);
    let user = await User.findOne({email: userEmail.email});
    if(user){
        var index = user.address.indexOf(req.params.id);
        
        if(index>=0){
            await user.address.splice(index,1);
            user = await user.save();
        }
    }
    Address.findByIdAndRemove(req.params.id).then(product=>{
        if(product){
            return res.status(200).json({success: true, message: 'The address is removed'});
        }else{
            return res.status(404).json({success: false, message:"Address not found"});
        }
    }).catch(err=>{
        return res.status(500).json({success: false, error: err})
    })
})

router.post("/add-to-cart", auth, async (req, res) => {
    try {
      
      const { id } = req.body;
      const product = await Product.findById(id);
      
      let user = await User.findOne({email : req.email});
     
      if (user.cart.length == 0) {
        user.cart.push({ product, quantity: req.body.quantity });
      } else {
        let isProductFound = false;
        for (let i = 0; i < user.cart.length; i++) {
          if (user.cart[i].product._id.equals(product._id)) {
            isProductFound = true;
          }
        }
  
        if (isProductFound) {
          let producttt = user.cart.find((productt) =>
            productt.product._id.equals(product._id)
          );
          producttt.quantity += req.body.quantity;
        } else {
          user.cart.push({ product, quantity: req.body.quantity });
        }
      }
      user = await user.save();
     
      res.json(user);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  
  router.delete("/remove-from-cart/:id", auth, async (req, res) => {
    try {
 
      const id  = req.params.id;
      const product = await Product.findById(id);
      let user = await User.findOne({email: req.email});
 
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          if (user.cart[i].quantity == 1) {
            user.cart.splice(i, 1);
          } else {
            user.cart[i].quantity -= 1;
          }
        }
      }
      user = await user.save();
      console.log(user);
      res.json(user);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
module.exports = router;



