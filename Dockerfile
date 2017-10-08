FROM elixir:1.5.2
MAINTAINER Peter Hastie <phastie@bleacherreport.com>
RUN apt-get update && apt-get install --yes \
 postgresql-client \
 inotify-tools
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
  apt-get install --yes nodejs
ADD . /app
RUN mix local.hex --force
WORKDIR /app
ENV MIX_ENV prod
RUN mix local.rebar --force
RUN mix do deps.get, compile
RUN npm install
EXPOSE 4000
CMD ["mix", "do", "ecto.migrate,", "phoenix.server"]
