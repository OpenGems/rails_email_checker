# frozen_string_literal: true

require 'rails_email_checker/configuration'
require 'rails_email_checker/constant'
require 'rails_email_checker/email_validator'
require 'rails_email_checker/helper_methods'
require 'rails_email_checker/address'

module RailsEmailChecker
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def address(value)
      Address.new(value)
    end
  end
end
