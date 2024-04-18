FROM ruby:3.0.2-alpine AS builder
RUN apk add \
    build-base \
    postgresql-dev

COPY Gemfile* .

ENV POSTGRES_DATABASE_PASSWORD="postgres"

RUN bundle install


FROM ruby:3.0.2-alpine AS runner
RUN apk add \
    tzdata \
    nodejs \
    postgresql-dev
WORKDIR /app

ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWD=postgres
ENV POSTGRES_HOST=localhost

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/

COPY . .

EXPOSE 3000

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

CMD ["rails", "server", "-b", "0.0.0.0"]

