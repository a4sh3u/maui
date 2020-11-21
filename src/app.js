const app = require('express')();
const mysql = require('mysql');

const bodyParser = require('body-parser');

app.use(bodyParser.json({
    limit: '8mb'
})); // support json encoded bodies

// environment variables
const PORT = process.env.PORT || 4000;
const HOST = process.env.HOST || '0.0.0.0';

// mysql credentials
const connection = mysql.createConnection({
    host: process.env.MYSQL_HOST || '127.0.0.1',
    user: process.env.MYSQL_USER || 'user',
    password: process.env.MYSQL_PASSWORD || 'password',
    database: process.env.MYSQL_DATABASE || 'db'
});

connection.connect((err) => {
    if (err) {
        console.error('error connecting mysql: ', err);
    } else {
        console.log('mysql connection successful');
        app.listen(PORT, HOST, (err) => {
            if (err) {
                console.error('Error starting  server', err);
            } else {
                console.log('server listening at port ' + PORT);
            }
        });
    }
});

// home page
app.get('/', (req, res) => {
    const query = 'SELECT msg FROM greeting';
    connection.query(query, (err, results, fields) => {
        if (err) {
            console.error(err);
            res.json({
                success: false,
                message: 'Error occured'
            });
        } else {
            const jstr = JSON.stringify(results);
            const j = JSON.parse(jstr)
            res.send(j[0].msg)
        }
    });
});
