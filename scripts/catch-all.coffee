module.exports = (robot) ->
  robot.catchAll (msg) ->
    botName = 'myhubot'
    if (!msg.message.text.startsWith(botName))
      return

    text = msg.message.text.substring(botName.length + 1)

    URL = 'http://openapi.tuling123.com/openapi/api/v2'
    API_KEY = process.env.TURING_API_KEY
    USER_ID = process.env.TURING_USER_ID
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

