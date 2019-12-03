FactoryBot.define do
  factory :exhibit do
    name                {"ああ"}
    price               {"1000"}
    status              {"新品"}
    description         {"今のトレンドです"}
    ship                {"1"}
    ship_fee            {"送料込み"}
    prefecture          {"大阪"}
    size                {"大きい"}

  end
end
