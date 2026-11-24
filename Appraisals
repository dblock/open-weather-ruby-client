# frozen_string_literal: true

# Hashie 6 no longer defines Dash/Trash property readers that conflict
# with existing methods, such as `min`, `max` and `zip`.
appraise 'hashie-5' do
  gem 'hashie', '~> 5.0'
end

appraise 'hashie-6' do
  gem 'hashie', '>= 6.0'
end
