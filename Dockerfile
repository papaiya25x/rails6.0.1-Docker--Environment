FROM ruby:2.6.3-alpine3.10

# パッケージのインストール
RUN apk update && apk upgrade && apk add --update build-base \
                                                  curl \
                                                  curl-dev \
                                                  less \
                                                  linux-headers \
                                                  libc6-compat \
                                                  libxml2-dev \
                                                  libxslt-dev \
                                                  nodejs \
                                                  pcre-dev \
                                                  ruby-dev \
                                                  tzdata \
                                                  yaml-dev \
                                                  zlib-dev \
                                                  sqlite-dev

# コンテナ上の作業ディレクトリの作成
RUN mkdir /app

# 作業ディレクトリの指定
WORKDIR /app

# gemのインストール
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN gem update bundler && bundle install

# ローカルのファイルを全てコンテナに追加
ADD . /app

# アプリケーションの起動設定
ENTRYPOINT ["/app/docker/scripts/docker-entrypoint.sh"]
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
