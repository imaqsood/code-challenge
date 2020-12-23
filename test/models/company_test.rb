require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test 'valid Comapny' do
    company = Company.new(
      name: "Wolf Painting",
      email: "wolf_painting@getmainstreet.com",
      zip_code: "30301",
      phone: "555-808-8888",
      services: "{Interior Painting, Commercial Painting, Exterior Painting}"
    )
    assert company.valid?
  end

  test 'invalid without name' do
    company = Company.new(
      name: "Wolf Painting",
      email: "wolf_painting@gogetmainstreet.com",
      zip_code: "30301",
      phone: "555-808-8888",
      services: "{Interior Painting, Commercial Painting, Exterior Painting}"
    )
    assert_not_nil company.errors[:email], 'email must end with @getmainstreet.com'
  end

  test 'City And State from Zip' do
    company = Company.new(
      name: "Wolf Painting",
      email: "wolf_painting@getmainstreet.com",
      zip_code: "30301",
      phone: "555-808-8888",
      services: "{Interior Painting, Commercial Painting, Exterior Painting}"
    )
    zip_code_data = ZipCodes.identify(company.zip_code)
    assert_equal company.city, zip_code_data[:city]
  	assert_equal company.state, zip_code_data[:state_name]
  end
end
