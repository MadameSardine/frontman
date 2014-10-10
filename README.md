# Chitter

#### (Makers Academy Week 4 Test)

## Task level 1
Write a Twitter clone that will allow the users to post messages to a public stream.

#### Features:
* In order to user chitter as a maker I want to sign up to the service
* In order to use chitter as a maker I want to log in
* In order to avoid others to use my account as a maker I want to log out
* In order to let people know what I am doing as a maker I want to post a message to chitter
* In order to see what people have to say as a maker I want to see all peeps in chronological order

#### Notes:
* Makers sign up to chitter with their email, password, name and a user name
* The username and email are unique
* Peeps (posts to chitter) have the name of the maker and their user handle
* Use BCrypt to secure the passwords
* Use DataMapper and Postgres to save the data
* You don't have to be logged in to see the peeps
* You only can peep in you are logged in

## Task level 2
The code has to be deployed to Heroku with two separate staging deployment targets: staging and production.
This means having two Heroku apps that are being deployed to and three GitHub remotes (origin, staging, production).

## Bonus features
* In order to start a conversation as a maker I want to reply to a peep from another maker
* Work on the CSS