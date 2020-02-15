# frozen_string_literal: true

require 'resolv'

module RailsEmailChecker
  class Address
    attr_reader :address

    def initialize(address)
      @address = address
      raise AddressArgument, "Invalid address #{address}" unless valid?(address)
    end

    def whitelisted?
      domain_include?(configuration.whitelist_domains)
    end

    def blacklisted?
      domain_include?(configuration.blacklist_domains)
    end

    def recorded?
      !records.nil? && records.any?
    end

    def formatted?
      !(address =~ configuration.regex_email).nil?
    end

    def sub_addressed?
      address.include?('+')
    end

    private

    def valid?(value)
      value.is_a?(String) && !value.nil? && !value.empty?
    end

    def domain_include?(list)
      list.include?(domain)
    end

    def domain
      @domain ||= address.gsub(/.+@/, '\1')
    end

    def records
      @records ||= dns
    end

    def configuration
      @configuration ||= RailsEmailChecker.configuration
    end

    def dns
      Resolv::DNS.open do |dns|
        dns.timeouts = configuration.timeouts || 2
        dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
      end
    rescue Resolv::ResolvError, Resolv::ResolvTimeout
      nil
    end
  end
end
