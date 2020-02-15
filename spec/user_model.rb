# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'active_model'

class User
  include ActiveModel::Validations

  def initialize(attributes = {})
    @attributes = attributes
  end

  def read_attribute_for_validation(key)
    @attributes[key]
  end
end

class User1 < User
  validates_email :email
end

class User2 < User
  validates_email :email, formatted: true
end

class User3 < User
  validates_email :email, blacklisted: true
end

class User4 < User
  validates_email :email, no_sub_addressed: true
end

class User5 < User
  validates_email :email, recorded: true
end