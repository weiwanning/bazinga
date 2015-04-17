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
  pg.connect process.env.DATABASE_URL, (error, client, done) ->
    client.query 'SELECT rumor FROM rumors ORDER BY random() LIMIT 1000', (err, result) ->
      done()
      if !err
        console.log "rows", result.rows[0]
        console.log "rumor", result.rows[0]['rumor']
        return result.rows[0]['rumor']
      else 
        console.error "find_rumor query error", err
        return "默默的八卦说完了，快洗洗睡吧"

insert_rumor = (message) ->
  pg.connect process.env.DATABASE_URL, (error, client, done) ->
    insertQuery = 'INSERT INTO rumors(rumor) VALUES (\'' + message + '\')'
    console.log "insertQuery", insertQuery
    client.query insertQuery, (err, result) ->
      done()
      if err
        console.error "insert_rumor query error", err

router.get "/", (req, resp) ->
  resp.status(200).send req.query.echostr

router.post "/", (req, resp) ->
  console.log "req from wechat:", req.body.xml

  tousername   = req.body.xml.tousername[0]
  fromusername = req.body.xml.fromusername[0]
  createtime   = parseInt req.body.xml.createtime[0]
  createtime   = createtime + 1
  message      = req.body.xml.content[0].toString()
  content      = "这也算八卦，太坑了吧，好歹说个有诚意的呗"

  if message.length >= 3
    content    = find_rumor()
    insert_rumor(message)

  resp.contentType "application/xml"
  str = "<xml><ToUserName>" + fromusername + "</ToUserName>
            <FromUserName>" + tousername   + "</FromUserName>
            <CreateTime>"   + createtime   + "</CreateTime>
            <MsgType>text</MsgType>
            <Content><![CDATA[" + content + "]]></Content></xml>"
  resp.status(200).send str

module.exports = router