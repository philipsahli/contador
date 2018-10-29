
const app = require('express')()
const moment = require('moment')
const metrics = require('graphite')
    .createClient(`plaintext://${process.env.METRIC_HOST}:${process.env.METRIC_PORT}/`)
const GracefulShutdownManager = require('@moebius/http-graceful-shutdown').GracefulShutdownManager;

const port = process.env.SERVICE_PORT
const instanceTraceId = traceId();

var counter = 0;

app.get('/counter', (req, res) => {    
    counter++;
    log(`Counting: ${counter}`, req.headers["x-trace-id"]);
    writeMetric(counter);
    setTimeout( ()=> res.send({counter}), 5000);
});

var ready = true;

app.get('/health/ready', (req, res) => {
    res.status(ready ? 200 : 503);
    res.send();
});
app.get('/health/live', (req, res) => res.send());

const server = app.listen(port, () => log(`Listening on port ${port}`));
const shutdownManager = new GracefulShutdownManager(server);

process.on('SIGTERM', () => {
    log("Shutdown requested");
    ready = false;
    setTimeout(() => shutdownManager.terminate(() => log('Server gracefully terminated')), 10000);
});

function log(message, traceId) {
    traceId = traceId || instanceTraceId;
    Object.assign(this, process.env)
    var timestamp = moment().format("YYYY-MM-DD hh:mm:ss,SSS");
    console.log(`${timestamp} ${SYSTEM_INSTANCE} contador ${SYSTEM_ENV} ${SERVICE_INSTANCE} INFO ${traceId} ${message}`);
}

function writeMetric(counter) {
    Object.assign(this, process.env)
    var metric = new Object();
    metric[`${SYSTEM_INSTANCE}.contador.${SYSTEM_ENV}.${SERVICE_INSTANCE}.counter.value`] = counter;
    metrics.write(metric);
}

function traceId() {
    return Math.random().toString(36).substring(2, 8);
}

log(`Process started with PID ${process.pid}`);