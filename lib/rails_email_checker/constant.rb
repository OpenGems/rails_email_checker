# frozen_string_literal: true

module RailsEmailChecker
  FileNotFound = Class.new(StandardError)
  ListArgument = Class.new(StandardError)
  AddressArgument = Class.new(StandardError)

  REGEX_EMAIL = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,6}\z/.freeze

  BLACKLIST_FILE = 'vendor/blacklist.txt'
  WHITELIST_FILE = 'vendor/whitelist.txt'
end
