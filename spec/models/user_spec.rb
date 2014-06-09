require 'rails_helper'

describe User do
  let(:user) { User.new }
  let(:attributes) { User::Attributes.new(user) }

  it { expect(subject).to have_many(:authorizations).dependent(:destroy) }

  describe '#values' do
    it 'should return an instance of attributes' do
      expect(user.values).to be_an_instance_of(User::Attributes)
    end

    it 'should return an instance of attributes initialized with himself' do
      expect(user.values.user).to be == user
    end

    it 'should return the same object on a second call' do
      expect(user.values).to be == user.values
    end
  end

  describe '#set_attributes_from_oauth' do
    before :each do
      allow(user).to receive(:values).and_return(attributes)
      allow(attributes).to receive(:set_from_oauth).and_return(user)
      @oauth = double
    end

    it 'should set the attributes and return self' do
      expect(user.set_attributes_from_oauth(@oauth)).to be == user
    end
  end

  describe '.new_from_oauth' do
    before :each do
      allow(User).to receive(:new).and_return(user)
      allow(user).to receive(:set_attributes_from_oauth).and_return(user)
      @oauth = double
    end

    it 'should initialize an user from oauth and return it' do
      expect(User.new_from_oauth(@oauth)).to be == user
    end
  end
end