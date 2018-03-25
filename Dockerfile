FROM ruby:2.5.0

RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler
ADD . /myapp

ENV PATH="/gems/home/bin:${PATH}"

CMD ["tail -f /dev/null"]
