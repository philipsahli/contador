
const app = require('express')()
const moment = require('moment')
const port = process.env.SERVICE_PORT

var counter = 0;

app.get('/counter', (req, res) => {    
    counter++;
    log(`Counting: ${counter}`);
    res.send({counter});
});

app.get('/health/ready', (req, res) => res.send());
app.get('/health/live', (req, res) => res.send());

app.listen(port, () => log(`Listening on port ${port}`));

function log(message) {
    Object.assign(this, process.env)
    var timestamp = moment().format("YYYY-MM-DD hh:mm:ss,SSS");
    console.log(`${timestamp} ${SYSTEM_INSTANCE} contador ${SYSTEM_ENV} ${SERVICE_INSTANCE} INFO ${message}`);
}