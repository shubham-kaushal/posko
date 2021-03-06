class SignInForm < FormObject
  attr_accessor :account_name, :email, :password

  validates :account_name, :email, :password, presence: true

  delegate :user, to: :service_object
  delegate :access_key, to: :service_object
  delegate :account, to: :service_object

  attr_reader

  def save
    if valid? && service_object.process
      true
    else
      errors.add(:base, 'Incorrect credentials')
      false
    end
  end

  def service_object
    @service_object ||= begin
      AuthenticationService.new(
        account_name: account_name,
        email: email,
        password: password
      )
    end
  end

  # def user
  #   service_object.user
  # end
end
