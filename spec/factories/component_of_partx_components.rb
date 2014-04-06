# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :component_of_partx_component, :class => 'ComponentOfPartx::Component' do
    part_id 1
    name "MyString"
    spec "MyText"
    last_updated_by_id 1
    qty 1
    unit "MyString"
  end
end
