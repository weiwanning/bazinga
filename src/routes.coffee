express     = require('express')
router      = express.Router()
faceScore   = require('./routers/face_score')
automomo    = require('./routers/automomo')

router.use "/play", faceScore
router.use "/automomo", automomo

router.all "*", (req, resp) ->
  resp.status(404).json message: "Not found"

module.exports = router