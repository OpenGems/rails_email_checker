# frozen_string_literal: true

require 'active_model'
require 'active_model/validations'
require 'rails_email_checker'

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if !value.present? || value.nil?
      add_error(record, attribute, :blank)
      return
    end

    address = RailsEmailChecker::Address.new(value)

    return if address.whitelisted?

    if options[:formatted] && !address.formatted?
      add_error(record, attribute)
      return
    end

    if options[:blacklisted] && address.blacklisted?
      add_error(record, attribute)
      return
    end

    if options[:no_sub_addressed] && address.sub_addressed?
      add_error(record, attribute)
      return
    end

    if options[:recorded] && !address.recorded?
      add_error(record, attribute)
      nil
    end
  end

  private

  def add_error(record, attribute, key = :invalid)
    record.errors.add(attribute, options[:message] || key)
  end
end
