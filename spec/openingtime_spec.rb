require_relative 'spec_helper'

describe OpeningTime do

  before :all do
    @ot = OpeningTime.instance
    @ot.times = {7 => 7..21, 
                 8 => {1..15 => 7...21, 16..31 => 7...20}}
  end

  describe '#open?' do

    describe 'simple month' do
      it 'is closed before opening time' do
        t = Time.new 2014, 7, 1, 5
        @ot.open?(t).should be_false
      end

      it 'is closed after closing time' do
        t = Time.new 2014, 7, 1, 22
        @ot.open?(t).should be_false
      end

      it 'is open in opening time' do
        t = Time.new 2014, 7, 1, 8
        @ot.open?(t).should be_true
      end
    end

    describe 'subranged month' do
      it 'is closed before opening time' do
        t = Time.new 2014, 8, 1, 5
        @ot.open?(t).should be_false
      end

      it 'is closed after closing time' do
        t = Time.new 2014, 8, 1, 22
        @ot.open?(t).should be_false
      end

      it 'is open in opening time' do
        t = Time.new 2014, 8, 1, 8
        @ot.open?(t).should be_true
      end

      it 'is open before nine in the first part' do
        t = Time.new 2014, 8, 1, 20, 55
        @ot.open?(t).should be_true
      end

      it 'is closed after nine in the first part' do
        t = Time.new 2014, 8, 1, 21, 5
        @ot.open?(t).should be_false
      end

      it 'is closed after eight in the second part' do
        t = Time.new 2014, 8, 16, 20, 5
        @ot.open?(t).should be_false
      end
    end

    describe 'unknown month' do
      it 'returns false' do
        t = Time.new 2015, 1, 1, 20, 5 # winter swimming!
        @ot.open?(t).should be_false
      end
    end

    describe 'open later on weekend' do
      it 'is closed before nine on July Saturday' do
        t = Time.new 2014, 7, 19, 8
        t.saturday?.should be_true # make sure
        @ot.open?(t).should be_false
      end

      it 'is open after nine on July Saturday' do
        t = Time.new 2014, 7, 19, 9
        @ot.open?(t).should be_true
      end

      it 'is closed before nine on July Sunday' do
        t = Time.new 2014, 7, 20, 8
        t.sunday?.should be_true # make sure
        @ot.open?(t).should be_false
      end

      it 'is open before nine on July Monday' do
        t = Time.new 2014, 7, 21, 8
        t.monday?.should be_true # make sure
        @ot.open?(t).should be_true
      end
    end
  end

  describe '#opening_time_for' do

    it 'returns range of hours' do
      t = Time.new 2014, 7, 21, 8
      @ot.opening_time_on(t).should be_a Range
    end

    it 'returns nil for a non-opening day' do
      t = Time.new 2014, 1, 1, 8
      @ot.opening_time_on(t).should === nil
    end

    it 'returns nil for a non-opening Sunday' do
      t = Time.new 2014, 1, 5, 8
      t.sunday?.should be_true
      @ot.opening_time_on(t).should === nil
    end
  end
end
