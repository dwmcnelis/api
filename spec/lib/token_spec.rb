# spec/lib/token_spec.rb

require 'rails_helper'

describe Token do
  subject { described_class }

  let!(:encoded) { "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiJjZGRlZGE2NC0zZjI2LTRhMDktYjk3Ni00OTJmOWUwZjIyZjIiLCJleHAiOjE0MjgzNjc2MzcwMDB9.OdDobI7aeCTn5ZCoC6rjWCxqK0ZVorrLulYFt9jE6kY" }
  let!(:payload) { {first: 'one', last: 'two'} }
  let!(:token_from_encoded) { Token.new(encoded: encoded) }
  let!(:token_from_payload) { Token.new(payload: payload) }
  let!(:token_with_error) { Token.new(encoded: 'xxxxxx') }

  it 'generates time now' do
    now = Token.now
    expect(now).to be_kind_of(Fixnum)
    expect(now).to be > 0
  end

  it 'generates time expires' do
    expires = Token.expires(5*60*1000)
    expect(expires).to be_kind_of(Fixnum)
    expect(expires).to be > 0
  end

  it 'converts to string' do
    expect(token_from_encoded.to_s).to eq(encoded)
  end

  it 'has proper length' do
    expect(token_from_encoded.length).to eq(encoded.length)
  end

  it 'detects valid token' do
    expect(token_from_payload.valid?).to eq(true)
  end

  it 'detects invalid token' do
    expect(token_from_encoded.valid?).not_to eq(true)
  end

  it 'detects expired token' do
    expect(token_from_encoded.expired?).to eq(true)
  end

  it 'detects expires token when present' do
    expect(token_from_encoded.expires?).to eq(true)
  end

  it 'detects expires token when not present' do
    expect(token_from_payload.expires?).not_to eq(true)
  end

  it 'detects error token' do
    expect(token_with_error.error?).to eq(true)
  end

  it 'detects no error token' do
    expect(token_from_payload.error?).not_to eq(true)
  end

  it 'calculates duration until expires' do
    duration = token_from_encoded.duration
    expect(duration).to be_kind_of(Fixnum)
    expect(duration).to be >= 0
  end

  it 'calculates duration until expires' do
    value = token_from_payload.fetch(:last)
    expect(value).to eq('two')
  end




end # User