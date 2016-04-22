require 'rspec'
require './being_lucky'

describe BeingLucky do
  describe '#score' do
    it 'when throw 5 1 3 4 1' do
      bl = BeingLucky.new([5,1,3,4,1])
      expect(bl.score).to eq 0 # when the score is less than 300 it can't accumulate points so it should be 0
      expect(bl.non_scoring_dice).to eq [3,4]
    end

    it 'when throw 1 1 1 3 1' do
      bl = BeingLucky.new([1,1,1,3,1])
      expect(bl.score).to eq 1100
      expect(bl.non_scoring_dice).to eq [3]
    end

    it 'when throw 2 4 4 5 4' do
      bl = BeingLucky.new([2,4,4,5,4])
      expect(bl.score).to eq 450
      expect(bl.non_scoring_dice).to eq [2]
    end

    it 'when throw 1 1 3 4 4' do
      bl = BeingLucky.new([1,1,3,4,4])
      expect(bl.score).to eq 0
      expect(bl.non_scoring_dice).to eq [4,4,3]
    end

    it 'when throw 2 4 4 5 4 6 more than 5 elements' do
      bl = BeingLucky.new([2,4,4,5,4,6])
      expect(bl.score).to eq 450
      expect(bl.non_scoring_dice).to eq [2]
    end

    it 'when throw 1 1 1 3 5' do
      bl = BeingLucky.new([1,1,1,3,5])
      expect(bl.score).to eq 1050
      expect(bl.non_scoring_dice).to eq [3]
    end
  end

  describe '#continue' do
    it 'when throw 4 3 3 4 1' do
      bl = BeingLucky.new([4,3,3,4,1])
      bl.continue
      expect(bl.score).not_to be_nil
    end

    it 'provided arg 1 1 5 5 to continue method' do
      bl = BeingLucky.new
      bl.continue([1,1,5,5])
      expect(bl.score).to eq 300
    end
  end
end
