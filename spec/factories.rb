FactoryGirl.define do
  factory :user do
    first_name 'Walter'
    last_name 'White'
    user_name 'heisenberg'
    password 'foo%bar'
    password_confirmation 'foo%bar'
  end

  sequence :title do
    "post_#{n}"
  end

  factory :post do
    title
    content 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolorem, perferendis pariatur perspiciatis saepe distinctio earum itaque. Odit, inventore, doloremque dolor magnam ex officiis accusantium dicta voluptas cumque ratione soluta quaerat!'
    user_id 1
    link true
    link_url 'http://www.weshargrove.com/'
  end
end