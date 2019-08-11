FROM ruby:2.6.3

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

RUN sed -i '/deb http:\/\/\(deb\|httpredir\).debian.org\/debian jessie.* main/d' /etc/apt/sources.list
RUN apt-get -o Acquire::Check-Valid-Until=false update

# Installing the 'apt-utils' package gets rid of the 'debconf: delaying package configuration,
# since apt-utils is not installed' error message when installing any other package with the
# apt-get package manager.
RUN apt-get install -y --no-install-recommends apt-utils

# Install some additional libraries
RUN apt-get update -yq && apt-get install -yq --no-install-recommends \
    build-essential \
    yarn

# Install nodejs
RUN apt-get update -yq \
    && apt-get install curl gnupg -yq \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash \
    && apt-get install -yq nodejs

# Set the locale
RUN apt-get install -y --no-install-recommends locales locales-all
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "LANG=en_US.UTF-8" >> /etc/environment
RUN echo "NODE_ENV=development" >> /etc/environment

# Cleanup
RUN apt-get update -yq && apt-get upgrade -yq && apt-get autoremove -yq
RUN apt-get autoclean -yq; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Configure the main working directory
RUN mkdir -p /app
WORKDIR /app

# Copy the Gemfile and Gemfile.lock and install Ruby Gems
ADD Gemfile ./Gemfile
ADD Gemfile.lock ./Gemfile.lock
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy the main application
ADD . ./

# Expose port 3000 to the Docker host
EXPOSE 3000

# Configure the entry point
ENTRYPOINT ["bundle", "exec"]