FactoryBot.define do
  factory :user do
    id                  {"21"}
    nickname            {"テストくん"}
    email               {"bbbbb@aaaaa.jp"}
    password            {"68k2GgBb"}
    year                {"1999"}
    month               {"12"}
    day                 {"31"}
    family_name_kanji   {"田中"}
    first_name_kanji    {"太郎"}
    family_name_kana   {"タナカ"}
    first_name_kana    {"タロウ"}
    phone_number       {"12345678901"}
  end
end
