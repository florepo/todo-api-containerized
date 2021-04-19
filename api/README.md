# Chargy Tech Test

A tool to analyze the favourite language of a GitHub user based on their published repositories.


[Link to live UI](https://relaxed-northcutt-b1ebbb.netlify.com/)

The tool utilizes the oktokit gem to connect to the GitHub API.

It will present an estimation of the favourite programming language of a user based on the language tags of its published repos.

Additionally it will present a breakdown of the number of repos per language.

PLEASE NOTE: The GitHub API publishes only the main language tag for a repo son stats are based on the the main repo tags.

## API-ENDPOINT

Live API endpoint can be found under:
https://git-coder.herokuapp.com/api/v1/

PLEASE NOTE: Only public accessible route is: 
GET .../profile/[:profile_name]

Example Output:

```
// https://git-coder.herokuapp.com/api/v1/profiles/octokit

{
  "data": {
    "languages": {
      "TypeScript": 24,
      "": 4,
      "JavaScript": 11,
      "Ruby": 2,
      "C#": 2,
      "Go": 1,
      "Objective-C": 1
    },
    "most_used_language": [
      "TypeScript"
    ],
    "total_repos": 45
  },
  "status": "ok"
}
```

## Install

### Clone the repository

```shell
git clone https://github.com/flow1981/chargy-backend
cd project
```

### Check your Ruby version

```shell
ruby -v
```

The output shows the current installed Ruby version and should be  `2.6.1`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv):

```shell
rbenv install '2.6.1'
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler)

```shell
bundle install
```

### Set authentification token for Octokit

Issue an authentofication token from your GitHub account to extend the API request limit to 5000 per hour (from 60 without authentification).

Set authentificationtoken in Rails via its credentials file (using Visual Studio Code):

```shell
EDITOR="code --wait" rails credentials:edit
```

Encrypted credential file opens and token needs to set with the following tags:

```xxxxx.credentials.yml
github:
  access_token: [your-token-here-without-quotation-marks]
```


### Initialize the database

```shell
rails db:create
```

### Add heroku remotes

Using [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli):

```shell
heroku login
heroku create [project-name]
git config --list | grep heroku
```

## Serve

```shell
rails s
```

## Test

In order to run the tests use:

```shell
bundle exec rspec
```

## Deploy

### With Heroku

Push to Heroku remote:

```shell

git push heroku master
heroku run rake db:migrate
heroku config:set RAILS_MASTER_KEY=[copy-key-here]
```

