describe 'date' do
  describe 'conversions' do
    before { @date = Date.new(2005, 2, 21) }

    describe '#iso8601' do
      it 'should convert to iso8601 format' do
        @date.iso8601.should == '2005-02-21'
      end
    end

    describe '#to_s' do
      it 'should convert to db format by default' do
        @date.to_s.should == '2005-2-21'
      end

      it 'should convert to short format' do
        @date.to_s(:short).should == '21 Feb'
      end

      it 'should convert to long format' do
        @date.to_s(:long).should == 'February 21, 2005'
      end

      it 'should convert to long_ordinal format' do
        @date.to_s(:long_ordinal).should == 'February 21st, 2005'
      end

      it 'should convert to db format' do
        @date.to_s(:db).should == '2005-02-21'
      end

      it 'should convert to rfc822 format' do
        @date.to_s(:rfc822).should == '21 Feb 2005'
      end

      it 'should convert to iso8601 format' do
        @date.to_s(:iso8601).should == '2005-02-21'
      end

      it 'should convert to xmlschema format' do
        @date.to_s(:xmlschema).should == '2005-02-21T00:00:00Z'
      end
    end

    describe '#readable_inspect' do
      it 'should convert to a readable string' do
        @date.readable_inspect.should == 'Mon, 21 Feb 2005'
      end

      it 'should also respond to #inspect' do
        @date.readable_inspect.should == @date.inspect
      end
    end

    describe '#xmlschema' do
      it 'should convert to xmlschema format' do
        @date.xmlschema.should == '2005-02-21T00:00:00Z'
      end
    end
  end
end
