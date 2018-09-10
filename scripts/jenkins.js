const JENKINS_URL = process.env.JENKINS_URL;
module.exports = (robot) => {
  robot.respond(/build (.*)/i, (res) => {
    const jobName = res.match[1]

    const url = JENKINS_URL + "/buildByToken/build?job=" + jobName + "&token=" + jobName;
    robot.http(url).get()((_err, _res, _body) => {
      if (_res.statusCode === 201) {
        res.reply("Ok, Start building...");
      } else {
        res.reply("皇上，臣妾做不到啊~");
      }
      robot.logger.debug(_body);
    });
  });
};
