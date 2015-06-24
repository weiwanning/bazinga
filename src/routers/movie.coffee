express     = require('express')
router      = express.Router()
MongoClient = require('mongodb').MongoClient

SIZE = 18523
mongoUrl = 'mongodb://head_less:head_less@ds045531.mongolab.com:45531/heroku_m0bf74pn'

router.get '/', (req, resp) ->
  #TODO define API here

router.post "/", (req, resp) ->
  console.log "movie req from wechat:", req.body.xml

  tousername   = req.body.xml.tousername[0]
  fromusername = req.body.xml.fromusername[0]
  createtime   = parseInt req.body.xml.createtime[0]
  createtime   = createtime + 1
  msgtype      = req.body.xml.msgtype[0]
  resp.contentType "application/xml"

  if msgtype == 'event'
    event = req.body.xml.event[0]
    if event == 'subscribe'
      content = "欢迎订阅自动的默默，非常荣幸默默能自动为您服务。"
    resp.status(200).send format_str fromusername, tousername, createtime, content
  else if msgtype == 'text'
    message = req.body.xml.content[0].toString()

    if message.match "电影"
      console.log "movie endpoint is called"
      MongoClient.connect mongoUrl, (err, db) ->
        if err
          console.error "Mongo connectiton failed.", err
        else
          console.log "Mongo connectiton succeed."
          cursor = db.collection('movies').find()

          skip = randomInt 0, SIZE
          console.log "Cursor size is:", SIZE
          console.log "Generate random number:", skip
          cursor.limit -1
          cursor.skip skip

          cursor.nextObject (err, item) ->
            if err
              console.log err
            else
              console.log 'Fetched:', item
              content = item.name + ", rating: " + item.rating + ", href: " + item.href
              resp.status(200).send format_str fromusername, tousername, createtime, content
    else
      content = "自动的默默有点厉害的"
      resp.status(200).send format_str fromusername, tousername, createtime, content

format_str = (tousername, fromusername, createtime, content) ->
  str = "<xml><ToUserName>"   + tousername   +  "</ToUserName>
              <FromUserName>" + fromusername +  "</FromUserName>
              <CreateTime>"   + createtime   +  "</CreateTime>
              <MsgType>text</MsgType>
              <Content><![CDATA[" + content + "]]></Content></xml>"
  return str

randomInt = (low, high) ->
    return Math.floor(Math.random() * (high - low) + low)

module.exports = router