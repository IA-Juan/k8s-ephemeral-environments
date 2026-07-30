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


async function getEnvironmentInfo(){

    const result = await pool.query(
        `
        SELECT
            id,
            environment,
            status,
            created_at
        FROM environment_info
        ORDER BY id
        `
    );

    return result.rows;

}


module.exports = {

    checkConnection,

    getEnvironmentInfo

};