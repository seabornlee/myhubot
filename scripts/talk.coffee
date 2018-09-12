module.exports = (robot) ->
  robot.hear /.*辛苦.*/i, (res) ->
    res.reply "我就是一个机器人，您这么关心我，我好感动~"
