## Being Lucky

Calculates score based on 5-dice combination. It also has the method to continue rolling based on number of non-scoring dice(s).

## Code Example

```ruby
bl = BeingLucky.new([1,1,1,3,5])
bl.score # returns 1050 points
bl.non_scoring_dice # returns [3]

bl.continue # continue rolling without argument returns random dice results
bl.continue([1,1,1]) # returns 1000 points
```
