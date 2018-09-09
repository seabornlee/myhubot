const JENKINS_URL = process.env.JENKINS_URL;
module.exports = (robot) => {
  robot.respond(/build (.*)/i, (res) => {
    const jobName = res.match[1]

    const url = JENKINS_URL + "/buildByToken/build?job=" + jobName + "&token=" + jobName;
    robot.http(url).get()((_err, _res, _body) => {
      robot.logger.debug(_body);
      res.reply("Ok, Start building...");
    });
  });
};
