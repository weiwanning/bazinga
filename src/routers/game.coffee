express = require('express')
router = express.Router()

# GET game page.
router.get '/', (req, resp) ->
  console.log "game page rendered"
  resp.render 'game.html'

module.exports = router;
