class AddressForm < Rectify::Form
  attribute :first_name, String
  attribute :last_name,  String
  attribute :address,    String
  attribute :city,       String
  attribute :phone,      String
  attribute :country,    String
  attribute :zipcode,    Integer
  attribute :addressable_type, String
  attribute :addressable_id,   Integer

  validates :first_name,
    :country,
    :last_name,
    :address,
    :city,
    :zipcode,
    :phone,
    presence: true

  validates :zipcode, numericality: true
end
