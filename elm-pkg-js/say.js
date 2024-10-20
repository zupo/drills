/* elm-pkg-js
port say : String -> Cmd msg
*/

exports.init = async function (app) {
  app.ports.say.subscribe(function (message) {
    console.log("Saying: " + message);
    utter = new SpeechSynthesisUtterance(message);
    utter.rate = 0.7;
    window.speechSynthesis.speak(utter);
  });
};
