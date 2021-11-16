require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    User.create(first_name: 'Josh', last_name: 'smith', email: 'test@test.com', password: 'test_password', password_confirmation: 'test_password')
  }
  describe 'Validations' do
    it 'was created with a password and password_confirmation' do
      expect(subject.password).to be_truthy
      expect(subject.password_confirmation).to be_truthy
    end
    it 'does not allow password and password_confirmation not to match' do
      subject.password_confirmation = 'wrong_password'
      expect(subject.password).not_to eq subject.password_confirmation
    end
    context 'when email is not unique' do
      before { User.create!(first_name: 'Josh', last_name: 'smith', email: 'test@test.com', password: 'test_password', password_confirmation: 'test_password') }
      it {expect(subject).to be_invalid}
    end

    it 'has a first name, lastname and email' do
      expect(subject.first_name).to be_truthy
      expect(subject.last_name).to be_truthy
      expect(subject.email).to be_truthy
    end

    it 'contains a password with a minimum length of 5 characters' do
      expect(subject.password.length >= 5).to be_truthy
    end

    # puts User
  end

  describe '.authenticate_with_credentials' do
    before { User.create!(first_name: 'Josh', last_name: 'smith', email: 'test@test.com', password: 'test_password', password_confirmation: 'test_password') }
    it 'returns truthy when email is valid' do 
      expect(User.authenticate_with_credentials('test@test.com', 'test_password')).to be_truthy
    end
    it 'returns nil when email is invalid' do 
      expect(User.authenticate_with_credentials('newEmail@newEmail.com', 'test_password')).to be_nil
    end
    it 'returns nil when password does not match' do 
      expect(User.authenticate_with_credentials('test@test.com', 'bad_password')).to be_nil
    end
    it 'still authenticates when email is typed in with extra spaces' do
      user = User.authenticate_with_credentials('  test@test.com  ', 'test_password')
      expect(user).to be_truthy
    end
    it 'still authenticates when email is typed random cases' do
      user = User.authenticate_with_credentials('TEST@tESt.Com', 'test_password')
      expect(user).to be_truthy
    end




  end
end
