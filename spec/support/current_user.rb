# frozen_string_literal: true

# Sets current user based on two acceptable values:
# 1. a symbol name of a user factory trait;
# 2. a specific instance of User.
def when_current_user_is(user)
  current_user =
    case user
    when :anyone, :anybody then create(:user)
    when Symbol then create(:user, user)
    when User then user
    when nil then nil
    else raise ArgumentError, 'Invalid user type'
    end
  login_as current_user
end
