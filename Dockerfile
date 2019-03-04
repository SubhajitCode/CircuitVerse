FROM ruby:2.5.1
#for proxy
ENV http_proxy http://172.16.2.30:8080
ENV https_proxy http://172.16.2.30:8080

RUN export HTTP_PROXY=http://172.16.2.30:8080
RUN export HTTPS_PROXY=http://172.16.2.30:8080
# set up workdir
RUN mkdir /circuitverse
WORKDIR /circuitverse

# install dependencies
RUN apt-get update -qq && apt-get install -y imagemagick && apt-get clean

COPY Gemfile /circuitverse/Gemfile
COPY Gemfile.lock /circuitverse/Gemfile.lock

RUN bundle install --without production

RUN wget -qO- https://deb.nodesource.com/setup_8.x | bash - && apt-get install -y nodejs && apt-get clean

# copy source
COPY . /circuitverse
