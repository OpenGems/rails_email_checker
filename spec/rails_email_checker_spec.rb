# frozen_string_literal: true

require 'user_model'

RSpec.describe RailsEmailChecker do
  describe 'Test configuration' do
    let(:configuration) do
      RailsEmailChecker.configuration
    end

    it 'returns a default regex' do
      expect(configuration.regex_email).to eql(RailsEmailChecker::REGEX_EMAIL)
    end

    it 'returns a default timeouts' do
      expect(configuration.timeouts).to eql(2)
    end

    it 'returns a default blacklist domains' do
      expect(configuration.blacklist_domains).to eql(configuration.send(:default_blacklist_domains))
    end

    it 'returns a default whitelist domains' do
      expect(configuration.whitelist_domains).to eql(configuration.send(:default_whitelist_domains))
    end

    it 'returns a new whitelist domains' do
      default_size = configuration.send(:default_whitelist_domains).size
      configuration.add_whitelist_domains(domains: 'test.com')
      expect(configuration.whitelist_domains.size).to eql(default_size + 1)
    end

    it 'returns a new blacklist domains' do
      default_size = configuration.send(:default_blacklist_domains).size
      configuration.add_blacklist_domains(domains: 'test.com')
      expect(configuration.blacklist_domains.size).to eql(default_size + 1)
    end

    it 'returns a raise error whitelist domains' do
      expect do
        configuration.add_whitelist_domains(path: 'test')
      end.to raise_error(RailsEmailChecker::FileNotFound)
    end

    it 'returns a raise error blacklist domains' do
      expect do
        configuration.add_blacklist_domains(path: 'test')
      end.to raise_error(RailsEmailChecker::FileNotFound)
    end

    it 'returns a valid configuration' do
      RailsEmailChecker.configure do |c|
        c.timeouts = 3
      end
      expect(RailsEmailChecker.configuration.timeouts).to eql(3)
    end
  end

  describe 'Test lib' do
    let(:address) do
      RailsEmailChecker.address('test@gmail.com')
    end

    it 'returns a raise error address' do
      expect do
        RailsEmailChecker.address(nil)
      end.to raise_error(RailsEmailChecker::AddressArgument)
    end

    it 'returns a valid formatted?' do
      expect(address.formatted?).to eql(true)
    end

    it 'returns a invalid sub_addressed?' do
      expect(address.sub_addressed?).to eql(false)
    end

    it 'returns a valid recorded?' do
      expect(address.recorded?).to eql(true)
    end

    it 'returns a valid whitelisted?' do
      expect(address.whitelisted?).to eql(true)
    end

    it 'returns a valid blacklisted?' do
      expect(address.blacklisted?).to eql(false)
    end

    it 'returns a invalid recorded?' do
      tmp = RailsEmailChecker.address('test@testtesttest.com')
      expect(tmp.recorded?).to eql(false)
    end
  end

  describe 'Test validation' do
    it 'returns a invalid valid? (empty)' do
      model = User5.new(email: '')
      expect(model.valid?).to eql(false)
    end

    it 'returns a valid valid? (whitelisted)' do
      model = User1.new(email: 'test@gmail.com')
      expect(model.valid?).to eql(true)
    end

    it 'returns a invalid valid? (formatted)' do
      model = User2.new(email: 'test@.com')
      expect(model.valid?).to eql(false)
    end

    it 'returns a invalid valid? (blacklisted)' do
      model = User3.new(email: 'test@yopmail.com')
      expect(model.valid?).to eql(false)
    end

    it 'returns a invalid valid? (no_sub_addressed)' do
      model = User4.new(email: 'test+test@testtesttest.com')
      expect(model.valid?).to eql(false)
    end

    it 'returns a invalid valid? (recorded)' do
      model = User5.new(email: 'test@testtesttest.com')
      expect(model.valid?).to eql(false)
    end
  end
end
