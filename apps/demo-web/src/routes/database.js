const router =
    require("express").Router();


const database =
    require("../services/database");


router.get("/", async(req,res)=>{


    try {


        const result =
            await database.checkConnection();


        res.json({

            database:"connected",

            time:
                result.now

        });


    }
    catch(error){


        res.status(500)
           .json({

            database:"error",

            message:error.message

           });


    }


});


module.exports = router;