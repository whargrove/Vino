# Vino

Vino is the very simple blog engine behind weshargrove.com.

## Setup

Vino is built on Ruby on Rails; uses PostgreSQL for database storage and Capistrano for deployment.

I'm assuming you already have Ruby and Ruby on Rails installed on your machine, so let's begin. (If you do not, check out [this guide](http://createdbypete.com/articles/ruby-on-rails-development-with-mac-os-x-mountain-lion/).)

### Development

I use OS X for development; if you use another OS you're on your own.

#### Clone repo to your local machine

Clone the git repository to your local machine

`git clone https://github.com/whargrove/Vino.git vino`

Change directory to the cloned repository

`cd vino`

#### Setup the application variables

First, create a usable application.yml. (You could `mv` if you don't want to keep the example around. config/application.yml is ignored for deployment purposes.)

`cp config/application.example.yml config/application.yml`

If you want to use a random `secret_key_base` for development then follow the next few steps. Otherwise, skip to Setup PostgreSQL.

`rake secret | pbcopy`

Open `config/application.yml`

Select default text

Command + V to paste new `secret_key_base`

#### Setup PostgreSQL

Use Homebrew to install PostgreSQL

`brew install postgresql`

Initialize PostgreSQL

`initdb /usr/local/var/postgres`

Create the database. (Replace `{user_name}` with your system user name.)

`createdb -U {user_name} blog_development`

Verify you can connect to the DB

`psql -d blog_development`

Finally, create a usable database.yml. (You could `mv` if you don't want to keep the example around. config/database.yml is ignored for deployment purposes.)

`cp config/database.example.yml config/database.yml`

Uncomment the development section

Add your user name. (Should be the same user that initialized and created the DB.)

#### Use Pow to serve the rack app

Install Pow

`curl get.pow.cx | sh`

Configure Pow to serve the app to http://app.dev

`cd ~/.pow`

`ln -s /path/to/app`

#### Install gem dependencies

Use Bundler to install gems

`bundle install`

#### Setup the database for development

Go back to the app root

`cd /path/to/app`

Migrate the database

`rake db:migrate RAILS_ENV=development`

#### Create a user

Go to http://vino.dev/signup in your browser.

(Note: In a production environment, your IP address is checked when going to /signup. I recommend adding your IP address as to `application.yml` so the app knows who is allowed to create a user.)

Enter your user name, first name, last name, and password to sign up.

After pressing 'Sign up' you will be redirected to /, go to http://vino.dev/login

After entering your user name and password you will be logged in and redirected to http://vino.dev/posts

Have at it!

## FAQ

### Why build a blog application instead of using Wordpress, Tumblr, Squarespace, etc.?

I've used many blogging platforms over the years and have never been 100% satisifed. I wanted a simple application that I could use that met very basic needs without a huge amount of overheard.

### Why Vino?

I like wine.

## Questions?

Shoot me an email at wesleyhargrove@gmail.com.
