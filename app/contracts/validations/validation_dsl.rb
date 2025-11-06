module Validations::ValidationDsl
  extend ActiveSupport::Concern
  
  RULES_DICTIONARY = {
    presence: Validations::Presence,
    length: Validations::Length,
    numeric: Validations::Numeric,
    space: Validations::Space,
    date_format: Validations::DateFormat
  }
  
  included do
    class << self
      attr_accessor :validations

    end
    @validations = []
  end

  module ClassMethods
    def my_validates(field, *args)
      self.validations << { args: args, field: field }
    end
  end

  def valid?
    @errors = []
    self.class.validations.each do |hash|
      field = hash[:field]
      hash[:args].each do |validates|
        validates.to_a.each do |val|
          rule_name, arg = val.first, val.last
          validator = RULES_DICTIONARY[rule_name].new(arg)
          unless validator.valid?(@params[hash[:field]])
            @errors << { "#{field}" => validator.errors }
          end
        end
      end
    end
    @errors.blank?
  end
end
