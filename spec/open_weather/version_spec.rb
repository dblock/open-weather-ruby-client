# frozen_string_literal: true

require 'spec_helper'

describe OpenWeather do
  it 'has a version' do
    expect(OpenWeather::VERSION).to_not be nil
  end
end
