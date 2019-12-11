FactoryBot.define do
  factory :exhibit do
    # id                  {"2"}
    name                {"ああ"}
    price               {"1000"}
    status              {"未使用に近い"}
    description         {"猫です"}
    ship                {"YOUメール"}
    ship_fee            {"送料込み"}
    prefecture          {"大阪"}
    size                {""}
    user_id             {"1"}
    buyer_id            {""}
    shipment            {"1日〜2日で発送"}
    category_id            {"28"}
  end
end