module PerformancesHelper
  
  def grade(p)
    if p >= 80
      "HD"
    elsif p >= 70
      "D"
    elsif p >= 60
      "C"
    elsif p >= 50
      "P"
    else
      "N"
    end
  end
  
  def grade_in_words(p)
    if p >= 80
      "High Distinction"
    elsif p >= 70
      "Distinction"
    elsif p >= 60
      "Credit"
    elsif p >= 50
      "Pass"
    else
      "Fail"
    end
  end
end
