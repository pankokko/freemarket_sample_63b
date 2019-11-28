FactoryBot.define do
  factory :user do
    nickname            {"DAIKI"}
    email               {"daiki@gmail.com"}
    password            {"123456789"} 
    year                {"1999"}
    month               {"12"}
    day                 {"31"}
    family_name_kanji   {"たなか"}    
    first_name_kanji    {"たかし"}
  end
end
