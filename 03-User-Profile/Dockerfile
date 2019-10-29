FROM ruby

RUN apt-get update
RUN apt-get -y install apt-utils
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get -y install nodejs
RUN apt-get -y install vim zsh less curl telnet
# RUN /bin/ls -lt /usr/bin
# RUN /bin/ls -lt /usr/local/bin
# RUN /usr/bin/npm install -g yarn

EXPOSE 3002

WORKDIR /tmp

RUN gem install bundler

COPY Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install

RUN mkdir /app

ADD . /app
WORKDIR /app

CMD "./startup.sh"
# CMD ["rails", "server", "-b", "0.0.0.0"]
