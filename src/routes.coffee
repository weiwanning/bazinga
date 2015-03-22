express     = require('express')
router      = express.Router()
create      = require('./routers/create')
camera      = require('./routers/camera')
draw        = require('./routers/draw')
game        = require('./routers/game')
faceScore   = require('./routers/face_score')
face        = require('./routers/face')

router.use "/index", create
router.use "/create.html", create
router.use "/camera.html", camera
router.use "/draw.html", draw
router.use "/game.html", game
router.use "/face_score.html", faceScore
router.use "/face.html", face

router.all "*", (req, resp) ->
  resp.status(404).json message: "Not found"

module.exports = router