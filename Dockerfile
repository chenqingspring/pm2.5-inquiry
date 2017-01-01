FROM ruby:2.0.0

RUN mkdir -p /opt/pm25

WORKDIR /opt/pm25

RUN gem install bundler -V

COPY Gemfile /opt/pm25/Gemfile
COPY Gemfile.lock /opt/pm25/Gemfile.lock
RUN bundle install --jobs 20 --retry 5 --without development test -V

COPY . /opt/pm25

ENV RACK_ENV=production
CMD bundle exec rackup config.ru -p 3000