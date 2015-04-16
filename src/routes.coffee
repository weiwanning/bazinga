express     = require('express')
router      = express.Router()
faceScore   = require('./routers/face_score')

router.use "/play", faceScore

router.get "/automomo", (req, resp) ->
  resp.status(200).send req.query.echostr

router.post "/automomo", (req, resp) ->
  console.log "req from wechat:", req.body.xml

  tousername   = req.body.xml.tousername[0]
  fromusername = req.body.xml.fromusername[0]
  createtime   = parseInt req.body.xml.createtime[0]
  createtime   = createtime + 1

  resp.contentType "application/xml"
  str = "<xml><ToUserName>" + fromusername + "</ToUserName>
            <FromUserName>" + tousername   + "</FromUserName>
            <CreateTime>"   + createtime   + "</CreateTime>
            <MsgType>text</MsgType><Content><![CDATA[papapa]]></Content></xml>"
  resp.status(200).send str

router.all "*", (req, resp) ->
  resp.status(404).json message: "Not found"

module.exports = router