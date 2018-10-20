
const app = require('express')()
const port = 3000

var counter = 0;

app.get('/counter', (req, res) => {
    counter++;
    res.send({counter});
})

app.listen(port, () => console.log(`Contador listening on port ${port}!`))


