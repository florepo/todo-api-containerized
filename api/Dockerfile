FROM ruby:2.6.1

ENV APP_DIRECTORY /app
ENV PORT 3000

RUN apt-get update -qq && apt-get install -y build-essential

RUN mkdir $APP_DIRECTORY
WORKDIR $APP_DIRECTORY

RUN gem install bundler --no-document
RUN gem install rails

ADD Gemfile* $APP_DIRECTORY/
RUN bundle check || bundle install --no-binstubs --jobs $(nproc) --retry 3

ADD . $APP_HOME

EXPOSE $PORT

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]