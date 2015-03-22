express = require('express')
router = express.Router()

# GET draw page.
router.get '/', (req, resp) ->
  console.log "score page rendered"
  resp.render 'score.html'

module.exports = router;
