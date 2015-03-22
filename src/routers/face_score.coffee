express = require('express')
router = express.Router()

# GET draw page.
router.get '/', (req, resp) ->
  console.log "face_score page rendered"
  resp.render 'face_score.html'

module.exports = router;
