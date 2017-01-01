FROM ruby:2.0.0

RUN mkdir -p /opt/pm25

WORKDIR /opt/pm25

RUN gem install bundler -V
RUN gem install nokogiri -v '1.6.1' -V

COPY . /opt/pm25

ENV RACK_ENV=production
CMD bundle exec rackup config.ru -p 3000