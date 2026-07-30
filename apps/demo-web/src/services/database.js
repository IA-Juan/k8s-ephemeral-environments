const { Pool } = require("pg");

const config = require("../config");


const pool = new Pool({

    host: config.database.host,

    port: config.database.port,

    database: config.database.database,

    user: config.database.user,

    password: config.database.password

});


async function checkConnection(){

    const result = await pool.query(
        "SELECT NOW()"
    );

    return result.rows[0];

}


module.exports = {

    checkConnection

};