express = require('express')
router = express.Router()

# GET face regonization page.
router.get '/', (req, resp) ->
  console.log "face page rendered"
  resp.render 'face.html'

module.exports = router;