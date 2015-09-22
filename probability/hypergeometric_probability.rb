module HypergeometricProbability

  def self.p(n, r)
    permutations = 1
    (n-r+1..n).each do |x|
      permutations *= x
    end
    permutations
  end

  def self.c(n, r)
    combinations = p(n, r)
    (1..r).each do |x|
      combinations /= x
    end
    combinations
  end

  def self.calculate(total, total_wanted, pick, pick_wanted, mode="=")

    probability = Rational(0)

    if mode.include? "="
      probability += Rational(c(total_wanted, pick_wanted) *
                              c(total - total_wanted, pick - pick_wanted),
                              c(total, pick))
    end

    if mode.include? "<"
      (0..pick_wanted).each do |x|
        probability += calculate(total, total_wanted, pick, x)
      end
    end

    if mode.include? ">"
      (pick_wanted+1..pick).each do |x|
        probability += calculate(total, total_wanted, pick, x)
      end
    end

    probability

  end

end

