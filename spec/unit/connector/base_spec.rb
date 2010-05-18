require 'spec_helper'

describe PartyResource::Connector::Base do
  describe "creation" do
    subject { PartyResource::Connector::Base.new(:test, options) }

    let_mock(:username)
    let_mock(:password)
    let_mock(:normalized_uri)
    let_mock(:original_uri)

    before do
      HTTParty.stub(:normalize_base_uri => normalized_uri)
    end

    context "with a base_uri" do
      let(:options) { { :base_uri => original_uri } }

      it 'normalizes the base_uri' do
        HTTParty.should_receive(:normalize_base_uri).with(original_uri)
        subject.options.should == {:base_uri => normalized_uri }
      end
    end

    context 'with username' do
      let(:options) { { :username => username } }

      it 'stores the username' do
        subject.options.should == {:basic_auth => {:username => username, :password => nil} }
      end
    end

    context 'with password' do
      let(:options) { { :password => password } }

      it 'stores the password' do
        subject.options.should == {:basic_auth => {:password => password, :username => nil} }
      end
    end

    context 'with all options' do
      let(:options) { { :base_uri => original_uri, :username => username, :password => password } }

      it 'stores the options' do
        subject.options.should == {:base_uri => normalized_uri, :basic_auth => {:password => password, :username => username } }
      end
    end
  end

end
