express = require('express')
router = express.Router()

# GET home page.
router.get '/', (req, resp) ->
  console.log "home page rendered"
  # resp.render 'index', { title: 'Express' }
  resp.json image: true

module.exports = router;
