const router = require("express").Router();

const config = require("../config");


router.get("/", (req,res)=>{


    res.render(
        "index",
        {

            environment:
                config.environment.name,

            namespace:
                config.environment.namespace

        }
    );


});


module.exports = router;
