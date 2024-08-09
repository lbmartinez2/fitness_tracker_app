require 'rails_helper'

RSpec.describe User, type: :model do
  # Define a valid user using FactoryBot
  let(:user) { FactoryBot.build(:user) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user.name = nil
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:exercises).dependent(:destroy) }
    it { is_expected.to have_many(:consumptions).dependent(:destroy) }
  end

  describe 'devise modules' do
    it 'includes database_authenticatable module' do
      expect(User.new).to be_a_kind_of(Devise::Models::DatabaseAuthenticatable)
    end

    it 'includes registerable module' do
      expect(User.new).to be_a_kind_of(Devise::Models::Registerable)
    end

    it 'includes recoverable module' do
      expect(User.new).to be_a_kind_of(Devise::Models::Recoverable)
    end

    it 'includes rememberable module' do
      expect(User.new).to be_a_kind_of(Devise::Models::Rememberable)
    end

    it 'includes validatable module' do
      expect(User.new).to be_a_kind_of(Devise::Models::Validatable)
    end
  end
end
