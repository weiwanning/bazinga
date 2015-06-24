express     = require('express')
router      = express.Router()
faceScore   = require('./routers/face_score')
rumors    = require('./routers/rumors')
movie       = require('./routers/movie')

router.use "/play", faceScore
router.use "/automomo", movie
router.use "/rumors", rumors

router.all "*", (req, resp) ->
  resp.status(404).json message: "Not found"

module.exports = router