const router =
    require("express").Router();


const database =
    require("../services/database");


router.get("/", async(req,res)=>{


    try {


        const connection =
            await database.checkConnection();


        const records =
            await database.getEnvironmentInfo();


        res.json({

            database:"connected",

            time:
                connection.now,

            records

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