# frozen_string_literal: true

module RailsEmailChecker
  class Configuration
    attr_accessor :regex_email,
                  :blacklist_domains,
                  :whitelist_domains,
                  :timeouts

    def initialize
      @regex_email = REGEX_EMAIL
      @blacklist_domains = default_blacklist_domains
      @whitelist_domains = default_whitelist_domains
      @timeouts = 2
    end

    def add_blacklist_domains(path: nil, domains: nil)
      raise ListArgument, 'Path or domains are nil' if valid_argument?(path, domains)
      add_blacklist(load_domains(path)) unless path.nil?
      add_blacklist(domains) unless domains.nil?
    end

    def add_whitelist_domains(path: nil, domains: nil)
      raise ListArgument, 'Path or domains are nil' if valid_argument?(path, domains)
      add_whitelist(load_domains(path)) unless path.nil?
      add_whitelist(domains) unless domains.nil?
    end

    private

    def valid_argument?(path, domains)
      path.nil? && domains.nil?
    end

    def default_blacklist_domains
      @default_blacklist_domains ||= load_domains(BLACKLIST_FILE)
    end

    def default_whitelist_domains
      @default_whitelist_domains ||= load_domains(WHITELIST_FILE)
    end

    def load_domains(path)
      domains = []
      file = File.open(path, 'r')
      file.each_line do |line|
        domain = line.strip
        domains << domain unless domain.nil?
      end
      domains
    rescue StandardError => e
      raise FileNotFound, "File not found: #{e}"
    end

    def add_blacklist(domains)
      @blacklist_domains.concat(domains) if domains.is_a?(Array)
      @blacklist_domains << domains if domains.is_a?(String)
    end

    def add_whitelist(domains)
      @whitelist_domains.concat(domains) if domains.is_a?(Array)
      @whitelist_domains << domains if domains.is_a?(String)
    end
  end
end
