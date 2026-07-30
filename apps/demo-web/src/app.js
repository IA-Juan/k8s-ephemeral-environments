const express = require("express");

const path = require("path");


const app = express();


app.set(
    "view engine",
    "ejs"
);


app.set(
    "views",
    path.join(__dirname,"views")
);


app.use(
    "/",
    require("./routes/index")
);


app.use(
    "/health",
    require("./routes/health")
);


app.use(
    "/ready",
    require("./routes/ready")
);


app.use(
    "/db",
    require("./routes/database")
);



module.exports = app;