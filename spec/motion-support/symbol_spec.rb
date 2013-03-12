describe 'symbol' do
  it 'titleizes symbols' do
    :this_is_a_test.titleize.should == 'This Is A Test'
  end
end
