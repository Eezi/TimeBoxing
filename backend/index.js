const express = require('express')
const app = express()

const port = process.env.port || 5000;

app.route("/").get((req, res) => res.json("First rest route"))

app.listen(5000, () => console.log(`Server is running at port ${port}`))