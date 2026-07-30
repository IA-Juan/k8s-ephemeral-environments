const router = require("express").Router();

const config = require("../config");

const database = require("../services/database");


router.get("/", async (req,res)=>{


    try {


        const records =
            await database.getEnvironmentInfo();


        res.render(
            "index",
            {

                environment:
                    config.environment.name,

                namespace:
                    config.environment.namespace,

                records

            }
        );


    }
    catch(error){


        res.status(500).send(
            `
            <h1>Application error</h1>
            <pre>${error.message}</pre>
            `
        );


    }


});


module.exports = router;