express = require('express')
router = express.Router()

# GET draw page.
router.get '/', (req, resp) ->
  console.log "draw page rendered"
  resp.render 'draw.html'

module.exports = router;
