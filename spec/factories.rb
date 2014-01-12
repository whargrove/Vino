FactoryGirl.define do
  factory :user do
    first_name 'Walter'
    last_name 'White'
    user_name 'heisenberg'
    password 'foo%bar'
    password_confirmation 'foo%bar'

    factory :invalid_user do
      first_name ''
      last_name ''
      user_name ''
      password ''
      password_confirmation ''
    end
  end

  factory :post do
    title 'post'
    content 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolorem, perferendis pariatur perspiciatis saepe distinctio earum itaque. Odit, inventore, doloremque dolor magnam ex officiis accusantium dicta voluptas cumque ratione soluta quaerat!'
    user_id 1
    link true
    link_url 'http://www.weshargrove.com/'
    published true

    factory :invalid_post do
      title ''
      content ''
      user_id nil
      link true
      link_url ''
      published true
    end
  end
end