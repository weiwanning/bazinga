express     = require('express')
router      = express.Router()
faceScore   = require('./routers/face_score')

router.use "/play", faceScore
router.post "/automomo", (req, resp) ->
  console.log "req from wechat:", req.body
  resp.status(200).json message: "automomo test"

router.all "*", (req, resp) ->
  resp.status(404).json message: "Not found"

module.exports = router