# FROM ruby:2.7.3


# WORKDIR /app


# RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client


# COPY Gemfile* ./
# RUN bundle install


# COPY . .





# COPY entrypoint.sh /usr/bin/
# COPY wait-for-it.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh /usr/bin/wait-for-it.sh
# ENTRYPOINT ["entrypoint.sh"]


# CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]





# FROM ruby:2.7.3
FROM ruby:2.7.3-bullseye
WORKDIR /app


RUN sed -i 's|http://deb.debian.org|http://archive.debian.org|g' /etc/apt/sources.list && \
    sed -i 's|http://security.debian.org|http://archive.debian.org|g' /etc/apt/sources.list && \
    apt-get update -qq && \
    apt-get install -y nodejs yarn postgresql-client

COPY Gemfile* ./
RUN bundle install

COPY . .

COPY entrypoint.sh /usr/bin/
COPY wait-for-it.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh /usr/bin/wait-for-it.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
