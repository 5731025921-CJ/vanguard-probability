module HypergeometricProbability

  def self.factorial(n)
    # Finding the factorial of n
    (1..n).reduce(:*) || 1
  end

  def self.p(n, r)
    # Finding how many permutations are there
    # when choosing r objects from n objects
    Rational(factorial(n), factorial(n - r))
  end

  def self.c(n, r)
    # Finding how many combinations are there
    # when choosing r objects from n objects
    Rational(p(n, r), factorial(r))
  end

  def self.calculate(total, total_wanted, pick, pick_wanted, mode="=")

    # Calculate the probability of desired number of wanted objects picked

    # total: total number of objects to choose from
    # total_wanted: total number of wanted objects
    # pick: number of objects picked
    # pick_wanted: desired number of wanted objects picked
    # mode: "=", "<", ">", "<=", or ">=", for specifying cumulation

    probability = Rational(0)

    if mode.include? "="
      probability += Rational(c(total_wanted, pick_wanted) *
                              c(total - total_wanted, pick - pick_wanted),
                              c(total, pick))
    end

    if mode.include? "<"
      (0..pick_wanted-1).each do |x|
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

