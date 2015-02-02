express = require('express')
router = express.Router()

# GET camera page.
router.get '/', (req, resp) ->
  console.log "camera page rendered"
  resp.render 'camera.html'

module.exports = router;
