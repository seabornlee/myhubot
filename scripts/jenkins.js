const JENKINS_URL = process.env.JENKINS_URL;
const JENKINS_JOB_PREFIX = process.env.JENKINS_JOB_PREFIX;
const JENKINS_JOB_TOKEN = process.env.JENKINS_JOB_TOKEN;
module.exports = (robot) => {
  robot.respond(/build (.*)/i, (res) => {
    const jobName = JENKINS_JOB_PREFIX + res.match[1]

    const url = JENKINS_URL + "/buildByToken/build?job=" + jobName + "&token=" + JENKINS_JOB_TOKEN;
    robot.http(url).get()((_err, _res, _body) => {
      robot.logger.debug(_body);
      res.reply("Ok, Start building...");
    });
  });
};
