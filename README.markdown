## What?

`thehunt` is a web app used to manage trivia questions via SMS. It integrates with [Twilio][twilio] to send and receive texts. You can maanage teams, set checkpoints and broadcast messages.

## Configuration

This is a standard [Ruby on Rails][rubyonrails] application, so deploy it as you would. There is a separate `config.yml` file for application settings. See the `config.yml.example` file for information.  Once you are ready, create Teams and Checkpoints in the application. Then a Team is ready to go, you need start it in the interface.

## The Mechanism

Teams are a way to group people who are working together. A Team also has a code, which is used for registering People with a Team.

Checkpoints control the flow of the questions. A Checkpoint has a message, which is the text message needed to trigger that checkpoint. The success string is sent when a Checkpoint is triggered, along with the response. Each Checkpoint has point value as well.

Each Team tracks which Checkpoint it is on. People can only trigger the current Checkpoint their team is on.

The Dashboard shows each team and their current progress. The Broadcast section is used to send messages to Teams or everyone participating.

## Room For Improvement

This application was written in handful of days, so there is plenty of room for polish. For example:

*   Authentication to the website is via HTTP Basic Auth, which isn't the best.
*   There are only settings for one set of Checkpoints, so once you run the system once, you need to manually delete everything to start over.
*   The theming is basic. It uses [Bourbon][bourbon] / [Neat][neat] / [Bitters][bitters] / [Refills][refills], so it could look much better.

## Comments? Concerns?

Fork and modify this application as you please. I'm welcome pull requests. If you need to reach me, [email][email] me.

  [twilio]: https://www.twilio.com "Twilio Cloud Communications - APIs for Voice and Text Messaging"
  [rubyonrails]: http://www.rubyonrails.org "Ruby on Rails"
  [bourbon]: http://bourbon.io "Bourben - A Sass Mixin Library"
  [neat]: http://neat.bourbon.io "Bourbon Neat"
  [bitters]: http://bitters.bourbon.io "Bitters - Predefined Styles for Bourbon"
  [refills]: http://refills.bourbon.io "Refills"
  [email]: mailto:stephen@gerstacker.us
