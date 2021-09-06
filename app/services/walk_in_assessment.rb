class WalkInAssessment
    def initialize(casestudy_id, assessor_id, name, email, passkey)
      @casestudy_id = casestudy_id
      @assessor_id = assessor_id
      @name = name
      @email = email
      @passkey = passkey
      @casestudy_user = CasestudyUser.new
      @user = User.new
    end

    def setup_assessment
        if @passkey == Casestudy.find(@casestudy_id).passkey
            
            if User.all.exists?(email: @email)
                @user = User.find_by(email: @email)
            else
                @user.name = @name
                @user.email = @email
                @user.password = "12341234"

                if !@user.save
                    return @casestudy_user
                end
            end

            @casestudy_user.user_id = @user.id
            @casestudy_user.assessor_id = @assessor_id
            @casestudy_user.casestudy_id = @casestudy_id
            @casestudy_user.status = "pending"
            @casestudy_user.time_elaspsed = 0
            @casestudy_user.save
            
        end
        @casestudy_user
    end
end