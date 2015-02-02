express = require('express')
router = express.Router()

# GET create srcode page.
router.get '/', (req, resp) ->
  console.log "create qrcode page rendered"
  resp.render 'create.html'
  # resp.json image: true

module.exports = router;
