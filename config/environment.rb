require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require 'hanami/view'
require 'hanami/assets'
require 'net/http'
require 'facebook/messenger'
require_relative './sidekiq'
require_relative '../lib/career_bot'
require_relative '../apps/web/application'
require_relative 'initializers/locale'

Hanami.configure do
  mount Web::Application, at: '/'

  model do
    adapter :sql, ENV['DATABASE_URL']

    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  # mailer do
  #   root 'lib/career_bot/mailers'
  #
  #   # See http://hanamirb.org/guides/mailers/delivery
  #   delivery do
  #     development :test
  #     test        :test

  #     # production :smtp, address: ENV['SMTP_PORT'], port: 1025
  #   end
  # end
end

Hanami.boot unless ENV['HANAMI_ENV'] == 'test'
