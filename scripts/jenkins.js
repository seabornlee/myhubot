const JENKINS_URL = process.env.JENKINS_URL;
const JENKINS_JOB_NAME = process.env.JENKINS_JOB_NAME;
const JENKINS_JOB_TOKEN = process.env.JENKINS_JOB_TOKEN;
module.exports = (robot) => {
  robot.respond(/jenkins:build/i, (res) => {
    const url = JENKINS_URL + "/buildByToken/build?job=" + JENKINS_JOB_NAME + "&token=" + JENKINS_JOB_TOKEN;
    robot.http(url).get()((_err, _res, _body) => {
      robot.logger.debug(_body);
      res.reply("Ok, Start building...");
    });
  });
};
