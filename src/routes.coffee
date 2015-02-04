express = require('express')
router = express.Router()
create = require('./routers/create')
camera = require('./routers/camera')
draw = require('./routers/draw')
game = require('./routers/game')

router.use "/index", create
router.use "/create.html", create
router.use "/camera.html", camera
router.use "/draw.html", draw
router.use "/game.html", game

router.all "*", (req, resp) ->
  resp.status(404).json message: "Not found"

module.exports = router