module AssessmentsHelper  
  def get_performance(enrollment, assessment)
    return Performance.where('enrollment_id = ? and assessment_id = ?', enrollment.id, assessment.id).last
  end
end
