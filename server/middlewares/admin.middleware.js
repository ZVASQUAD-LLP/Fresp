const jwt = require("jsonwebtoken");

const admin = async(req, res, next)=>{
    try{
        const token = req.header('x-auth-token');
        if(!token)
        return res.status(401).json({msg: "No auth token, access denied"});
        const isVerified = jwt.verify(token, process.env.SECRET );
        if(isVerified.isAdmin == false)
        return res.status(401).json({msg: "Token verification failed, authorization denied"});
        req.user = isVerified.userId;
        req.token = token;
        next();
    }catch(e){
        res.status(500).json({error: e.message});
    }
}

module.exports = admin;