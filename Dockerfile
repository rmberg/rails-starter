FROM ruby:2.4.3

RUN apt-get update -qq && apt-get install -y build-essential apt-transport-https apt-utils
RUN apt-get install -y libxml2-dev libxslt1-dev

# node
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y yarn

RUN mkdir -p /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN gem install bundler && bundle install --jobs 20 --retry 5

ADD . /app
RUN yarn install

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]

CMD ["foreman", "start"]
