FROM ruby:2.3.3

RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
    build-essential \
    apt-transport-https \
    libpq-dev libxml2-dev libxslt1-dev libqt4-webkit libqt4-dev\
    xvfb

# Install Node.js 6.x repository
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends \
    nodejs

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends \
    yarn \
    && rm -rf /var/lib/apt/lists

ENV APP_HOME /opt/app/

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install
CMD [ "yarn install" ]

ADD . $APP_HOME