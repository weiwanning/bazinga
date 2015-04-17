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

find_rumor = (cb) ->
  pg.connect process.env.DATABASE_URL, (error, client, done) ->
    client.query 'SELECT rumor FROM rumors ORDER BY random() LIMIT 1000', (err, result) ->
      done()
      if !err
        cb result.rows[0]['rumor']
      else 
        console.error "find_rumor query error", err
        cb "默默的八卦说完了，快洗洗睡吧"

insert_rumor = (message) ->
  pg.connect process.env.DATABASE_URL, (error, client, done) ->
    insertQuery = 'INSERT INTO rumors(rumor) VALUES (\'' + message + '\')'
    console.log "insertQuery", insertQuery
    client.query insertQuery, (err, result) ->
      done()
      if err
        console.error "insert_rumor query error", err

format_str = (tousername, fromusername, createtime, content) ->
  str = "<xml><ToUserName>"   + tousername   +  "</ToUserName>
              <FromUserName>" + fromusername +  "</FromUserName>
              <CreateTime>"   + createtime   +  "</CreateTime>
              <MsgType>text</MsgType>
              <Content><![CDATA[" + content + "]]></Content></xml>"
  return str

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
  resp.contentType "application/xml"

  if message.length >= 4
    find_rumor (content) ->
      insert_rumor(message)
      resp.status(200).send format_str fromusername, tousername, createtime, content
  else
    resp.status(200).send format_str fromusername, tousername, createtime, content

module.exports = router


