require 'pry'

class BeingLucky
  THREE_SCORES = { 1 => 1000, 6 => 600, 5 => 500, 4 => 400, 3 => 300, 2 => 200 }
  ONE_SCORES = { 1 => 100, 5 => 50 }

  def initialize(dice=[])
    @dice = dice.take(5) # just set to maximum 5 elements
    @non_scoring_dice = []

    calculate_score
  end

  attr_accessor :dice, :non_scoring_dice, :score

  def continue(arr=[]) # Assuming it will produce a randomed set of array
    if arr.any?
      @dice = arr.take(5)
      @non_scoring_dice = []

      calculate_score
    else
      if @non_scoring_dice.any?
        @dice = []
        @non_scoring_dice.length.times do 
          @dice << rand(1..6)
        end
        @non_scoring_dice = []
        calculate_score
      end
    end
  end

  protected

  def calculate_score
    @score = 0
    single_arr = @dice - dup_hash.keys

    calculate_hash_score(dup_hash)
    calculate_single_score(single_arr)

    @score = 0 unless @score >= 300
  end

  def dup_hash # converts an array into a hash with a number of equal elements
    @dice.inject(Hash.new(0)) { |h,e| h[e] += 1; h }.select { 
      |k,v| v > 1 }.inject({}) { |r, e| r[e.first] = e.last; r }
  end

  def add_one_scores(key, number)
    if ONE_SCORES.include? key
      @score +=  number * ONE_SCORES[key]
    else
      number.times { @non_scoring_dice << key }
    end
  end

  def add_three_scores(key)
    if THREE_SCORES.include? key
      @score += THREE_SCORES[key]
    end
  end

  def calculate_hash_score(hash)
    hash.each do |k,v|
      add_one_scores(k, v) if v < 3
      add_three_scores(k) if v == 3

      if v > 3
        remaining = v - 3

        add_three_scores(k)
        add_one_scores(k, remaining)
      end
    end
  end

  def calculate_single_score(arr)
    arr.each do |item|
      if ONE_SCORES.include? item
        @score += ONE_SCORES[item]
      else
        @non_scoring_dice << item
      end
    end
  end
end
