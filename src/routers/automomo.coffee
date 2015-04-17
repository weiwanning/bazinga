express = require('express')
router = express.Router()
elizaBot = require('eliza/elizabot.js')
pg = require('pg')

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

find_rumor = () ->
  console.log process.env.DATABASE_URL
  pg.connect process.env.DATABASE_URL, (err, client, done) ->
    console.log "err", err
    client.query 'SELECT * FROM rumors', (err, result) ->
      done()
      if !err
        console.log result.rows

router.get "/", (req, resp) ->
  resp.status(200).send req.query.echostr

router.post "/", (req, resp) ->
  console.log "req from wechat:", req.body.xml

  tousername   = req.body.xml.tousername[0]
  fromusername = req.body.xml.fromusername[0]
  createtime   = parseInt req.body.xml.createtime[0]
  createtime   = createtime + 1
  message      = req.body.xml.content[0]

  find_rumor()
  content      = "默默正在升级中，请耐心等待"
  # content = parse_message tousername, fromusername, message

  resp.contentType "application/xml"
  str = "<xml><ToUserName>" + fromusername + "</ToUserName>
            <FromUserName>" + tousername   + "</FromUserName>
            <CreateTime>"   + createtime   + "</CreateTime>
            <MsgType>text</MsgType>
            <Content><![CDATA[" + content + "]]></Content></xml>"
  resp.status(200).send str

module.exports = router