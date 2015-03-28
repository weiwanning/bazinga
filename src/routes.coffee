express     = require('express')
router      = express.Router()
faceScore   = require('./routers/face_score')

router.use "/play", faceScore
router.all "*", (req, resp) ->
  resp.status(404).json message: "Not found"

module.exports = router