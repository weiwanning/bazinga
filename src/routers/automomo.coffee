express = require('express')
router = express.Router()
elizaBot = require('eliza/elizabot.js')

elizas = {}

parse_message = (from, to, message) ->
  say = ""
  eliza = elizas[from]
  if !eliza
    eliza = elizas[from] = new elizaBot
    say = elizas[from].getInitial()
    eliza.transform(message)
  else
    say = eliza.transform(message)
  return say

router.get "/", (req, resp) ->
  resp.status(200).send req.query.echostr

router.post "/", (req, resp) ->
  console.log "req from wechat:", req.body.xml

  tousername   = req.body.xml.tousername[0]
  fromusername = req.body.xml.fromusername[0]
  createtime   = parseInt req.body.xml.createtime[0]
  createtime   = createtime + 1
  message      = req.body.xml.content[0]

  content = parse_message tousername, fromusername, message

  resp.contentType "application/xml"
  str = "<xml><ToUserName>" + fromusername + "</ToUserName>
            <FromUserName>" + tousername   + "</FromUserName>
            <CreateTime>"   + createtime   + "</CreateTime>
            <MsgType>text</MsgType>
            <Content><![CDATA[" + content + "]]></Content></xml>"
  resp.status(200).send str

module.exports = router