class User < ActiveRecord::Base
  validates :email, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_secure_password

  def self.authenticate_with_credentials(email, password)
    email_no_spaces = email.strip
    email_even_cases = email_no_spaces.downcase
    user = User.find_by(email: email_even_cases)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
    
  end

end
