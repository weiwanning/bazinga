express = require('express')
router = express.Router()
create = require('./routers/create')
camera = require('./routers/camera')

router.use "/index", create
router.use "/create.html", create
router.use "/camera.html", camera

router.all "*", (req, resp) ->
  resp.status(404).json message: "Not found"

module.exports = router