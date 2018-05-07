require "test_helper"

describe Customer do
  describe "create from json" do
    it "can create a new instance from hash" do
      hash = {
      "name" => "Shelley Rocha",
      "registered_at" => "Wed, 29 Apr 2015 07:54:14 -0700",
      "address" => "Ap #292-5216 Ipsum Rd.",
      "city" => "Hillsboro",
      "state" => "OR",
      "postal_code" => "24309",
      "phone" => "(322) 510-8695"
      }
      expected_creation = DateTime.parse("Wed, 29 Apr 2015 07:54:14 -0700")

      previous_count = Customer.count
      result = Customer.create_from_json(hash)
      result.must_be_kind_of Customer
      result.name.must_equal hash["name"]
      result.created_at.must_equal expected_creation
      Customer.count.must_equal previous_count + 1
    end

    it "does not create a customer with incomplete data" do
      hash = {
      "city" => "Hillsboro",
      "state" => "OR",
      "postal_code" => "24309",
      "phone" => "(322) 510-8695"
      }

      previous_count = Customer.count
      proc {
        Customer.create_from_json(hash)
      }.must_raise
      Customer.find_by(phone: hash["phone"]).must_be_nil
      Customer.count.must_equal previous_count
    end
  end

end