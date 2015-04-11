require_relative '../tests/spec_helper'
require 'json'

describe 'Pagination' do
  url = '/v0/courses'

  describe '/courses' do

    describe 'per_page' do
      before { get url }

      it 'should not be > 100' do
      end

      it 'should always at least return 1 course' do
      end
    end

    describe 'response headers' do
      # https://developer.github.com/v3/#link-header
      it 'should have a properly formatted Link' do
      end

      it 'should have X-Total-Count' do
      end
    end
  end
end
