class Company < ApplicationRecord
  DEFAULT_BRAND_COLOR = '#61a946'.freeze

  has_rich_text :description

  validates_with EmailValidator, if: :email?

  after_initialize :set_city_and_state_using_zip_code, if: :zip_code?
  after_initialize :set_defaults

  def zipcode=(val)
    set_city_and_state_using_zip_code(val)
    super
  end

  private

  def set_defaults
    self.brand_color ||= DEFAULT_BRAND_COLOR
  end

  def set_city_and_state_using_zip_code(val = self.zip_code)
    return if self.city? and self.state?
    zip_code_data = ZipCodes.identify(val)
  	self.city = zip_code_data[:city]
  	self.state = zip_code_data[:state_name]
  end
end
