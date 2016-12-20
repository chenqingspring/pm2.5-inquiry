FROM ruby:2.0.0

RUN mkdir -p /opt/pm25

WORKDIR /opt/pm25

RUN gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
RUN gem install bundler -V

COPY Gemfile /opt/pm25/Gemfile
COPY Gemfile.lock /opt/pm25/Gemfile.lock
RUN bundle install --jobs 20 --retry 5 -V

COPY . /opt/pm25

CMD bundle exec rackup config.ru -p 3000