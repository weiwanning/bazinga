express = require('express')
router = express.Router()
index = require('./routers/index')

router.use "/index", index

router.all "*", (req, resp) ->
  resp.status(404).json message: "Not found"

module.exports = router