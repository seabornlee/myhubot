module.exports = (robot) ->
  robot.respond(/(.*)的id是/i,  (res) ->
    LOGIN_URL = process.env.BASE_URL + process.env.LOGIN_URL
    USERNAME = process.env.USERNAME
    PASSWORD = process.env.PASSWORD

    bin_no = res.match[1]
    console.log(bin_no)

    params = {
      type: 'account',
      mobile: USERNAME,
      username: USERNAME,
      password: PASSWORD
    }
    robot
      .http(LOGIN_URL)
      .header('Content-Type', 'application/json')
      .post(JSON.stringify(params)) (err, _res, body) ->
        data = JSON.parse(body)
        token = data.token

        WAREHOUSE_BIN_URL = process.env.BASE_URL + process.env.WAREHOUSE_BIN_URL + bin_no
        robot
          .http(WAREHOUSE_BIN_URL)
          .header('ACL-Token', token)
          .get() (err, _res, body) ->
            data = JSON.parse(body)
            if (data.results.length == 0)
              res.reply('找不到它的 ID')
            else
              res.reply('它的 Id 是 ' + data.results[0].id)
  )

