class Sessions::CreateService
  attr_reader :user, :password

  def initialize(user:, password:)
    @user = user
    @password = password
  end

  def call

  end
end
