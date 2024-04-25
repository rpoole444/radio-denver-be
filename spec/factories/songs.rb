FactoryBot.define do
  factory :song do
    name { "MyString" }
    artist { "MyString" }
    album { "MyString" }
    duration { 1 }
    playlist { nil }
  end
end
