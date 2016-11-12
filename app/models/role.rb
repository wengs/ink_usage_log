class Role < ActiveRecord::Base
  NAMES= %w(admin io_user tester io_admin operator)

  has_many :users
end
