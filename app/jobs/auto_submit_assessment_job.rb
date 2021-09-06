class AutoSubmitAssessmentJob < ApplicationJob
    queue_as :default

    def perform(casestudy_user_id)
        casestudy_user = CasestudyUser.find(casestudy_user_id)
        casestudy_user.status = "completed"
        casestudy_user.time_elaspsed = casestudy_user.casestudy.duration
        casestudy_user.completed_time = DateTime.now
        casestudy_user.save
    end
end