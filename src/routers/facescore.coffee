express = require('express')
router = express.Router()

# GET draw page.
router.get '/', (req, resp) ->
  console.log "facescore page rendered"
  resp.render 'facescore.html'

module.exports = router;
