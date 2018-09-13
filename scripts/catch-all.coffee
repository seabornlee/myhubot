module.exports = (robot) ->
  robot.catchAll (msg) ->
    BOT_NAME = process.env.BOT_NAME
    URL = process.env.TURING_API_URL
    API_KEY = process.env.TURING_API_KEY
    USER_ID = process.env.TURING_USER_ID

    if (!msg.message.text.startsWith(BOT_NAME))
      return

    text = msg.message.text.substring(BOT_NAME.length + 1)

    params = {
      reqType: '0',
      perception: {
        inputText: {
          text: text
        }
      }
      userInfo: {
        apiKey: API_KEY,
        userId: USER_ID
      }
    }
    robot.http(URL).post(JSON.stringify(params)) (err, _res, body) ->
      data = JSON.parse(body)
      data.results.forEach((r) ->
        if (r.resultType == 'text')
          msg.reply r.values.text
      )

