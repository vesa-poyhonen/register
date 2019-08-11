**README**

User registration system in Ruby on Rails. The system would require following features:

* As a user, I can visit sign up page and sign up with my email (with valid format and unique in database) and password (with confirmation and at least eight characters).
* When I sign up successfully, I would see my profile page.
* When I sign up successfully, I would receive a welcome email.
* When I sign up incorrectly, I would see error message in sign up page.
* As a user, I can edit my username and password in profile page. I can also see my email in the page but I can not edit it.
* When I first time entering the page, my username would be my email prefixing, e.g. (email is “user@example.com” , username would be “user”)
* When I edit my username, it should contain at least five characters. (Default username does not has this limitation)
* As a user, I can log out the system.
* When I log out, I would see the login page.
* As a user, I can visit login page and login with my email and password.
* As a user, I can visit login page and click “forgot password” if I forgot my password.
* When I visit forgot password page, I can fill my email and ask the system to send reset password email.
* As a user, I can visit reset password page from the link inside reset password email and reset my password (with confirmation and at least eight characters).
* The link should be unique and only valid within six hours.

**System dependencies**
* Ruby ruby-2.6.3 (on Rails 5.1.6)

**Getting started**
* Run <tt>dock build</tt> and <tt>dock run</tt> to build and start Docker
* Access application at http://localhost:3000
* Access docker by running <tt>dock bash</tt> and run tests <tt>rails test RAILS_ENV=test</tt>

**Docker**
* <tt>dock build</tt> (Re)builds the docker image
* <tt>dock run</tt> Runs the docker
* <tt>dock bash</tt> Opens bash inside the docker
* <tt>dock clean</tt> Deletes all unused docker data

**Other**
* Clean cache and temporary files: <tt>rails tmp:cache:clear</tt>
