== README

EventsHub is a web application used to create interactive business travel offers.

=== System dependencies
* Ruby ruby-2.6.3 (on Rails 5.1.6)

=== Configuration
* mailcatcher for development
1. gem install mailcatcher
2. Edit config.action_mailer.smtp_settings in development.rb
3. Set <tt>address: 'mailcatcher'</tt> and <tt>port: 1025</tt>
4. Run <tt>mailcatcher</tt> in console
5. Go to http://localhost:1080/

=== Docker
* <tt>dock bash</tt> Opens bash inside the docker
* <tt>dock run</tt> Runs the docker
* <tt>dock build</tt> (Re)builds the docker image
* <tt>dock clean</tt> Deletes all unused docker data

=== Other
* Clean cache and temporary files: <tt>rails tmp:cache:clear</tt>
