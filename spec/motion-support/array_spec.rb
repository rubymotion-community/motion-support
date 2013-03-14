describe 'array' do
  it 'determines when an array is empty' do
    [1, 2, 3].should.not.be.empty
    [].should.be.empty
  end

  it 'finds hash values' do
    array_of_hashes = [
      {
        line1: 3,
        line2: 5
      },
      {
        line3: 7,
        line4: 9
      }
    ]
    array_of_hashes.has_hash_value?(5).should.be.true
    array_of_hashes.has_hash_value?(4).should.not.be.true
  end
end
