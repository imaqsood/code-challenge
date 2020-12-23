class EmailValidator < ActiveModel::Validator
  EMAIL_REGEX = /A[0-9a-z._-]+@[0-9a-z._-]+\z/i.freeze
  EMAIL_DOMAIN = '@getmainstreet.com'.freeze

  def validate(record)
    email_field  = options[:email_field]&.to_sym || :email
    email = record.send(email_field)&.downcase
    message = []
    message << "email must end with #{EMAIL_DOMAIN}" unless email.end_with?(EMAIL_DOMAIN)
    message << "email can only contains (0 to 9, a to z, ., _, -) characters" unless EMAIL_REGEX =~ email
    record.errors.add(email_field, message.join(', ')) if message.present?
  end
end
