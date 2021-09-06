require "rails_helper"

RSpec.describe "routes for casestudy", :type => :routing do

    it "routes for home" do
        expect(get: "/").to route_to(controller: "home", action:"index")
    end

    it "routes for dashboard" do
        expect(get: "/candidate_dashboard").to      route_to(controller: "dashboard", action: "candidate_dashboard")
        expect(get: "/assessor_dashboard").to       route_to(controller: "dashboard", action: "assessor_dashboard")
        expect(get: "/contentcreator_dashboard").to route_to(controller: "dashboard", action: "contentcreator_dashboard")
    end

    it "routes for walk_in" do
        expect(get: "walk_in/casestudies/1/users/2").to     route_to(controller: "walk_in", action: "new", casestudy_id:"1", assessor_id:"2")
        expect(post: "walk_in/casestudies/1/users/2").to    route_to(controller: "walk_in", action: "create", casestudy_id:"1", assessor_id:"2")     
    end

    it "routes for role_users" do
        expect(post: "/role_users").to      route_to(controller: "role_users", action: "create")
        expect(get: "/role_users/new").to   route_to(controller: "role_users", action: "new")
    end
    
    it "routes for traits" do
        expect(post: "/traits").to      route_to(controller: "traits", action: "create")
        expect(get: "/traits/new").to   route_to(controller: "traits", action: "new")
    end

    it "routes for casestudy_users" do
        expect(get: "/casestudy_users").to      route_to(controller: "casestudy_users", action: "index")
        expect(post: "/casestudy_users").to     route_to(controller: "casestudy_users", action: "create")
        expect(get: "/casestudy_users/new").to  route_to(controller: "casestudy_users", action: "new")
    end

    it "routes for casestudy_users/user_responses" do
        expect(get: "/casestudy_users/1/instructions").to       route_to(controller: "user_responses", action: "instructions",      casestudy_user_id:"1")
        expect(get: "/casestudy_users/1/assessment").to         route_to(controller: "user_responses", action: "assessment",        casestudy_user_id:"1")
        expect(get: "/casestudy_users/1/submit_assessment").to  route_to(controller: "user_responses", action: "submit_assessment", casestudy_user_id:"1")
        expect(patch: "/casestudy_users/1/save_response").to    route_to(controller: "user_responses", action: "save_response",     casestudy_user_id:"1")
        expect(patch: "/update_time").to                        route_to(controller: "user_responses", action: "update_time_elapsed")
    end

    it "routes for assessor_response" do
        expect(get: "assessor/2/assessments").to                route_to(controller: "assessor_responses", action: "index",             assessor_id:"2")
        expect(get: "assessor/casestudy_user/1").to             route_to(controller: "assessor_responses", action: "assess",            casestudy_user_id:"1")
        expect(patch: "assessor/casestudy_user/1/update").to    route_to(controller: "assessor_responses", action: "update_rating",     casestudy_user_id:"1")
        expect(get: "assessor/casestudy_user/1/show").to        route_to(controller: "assessor_responses", action: "show",              casestudy_user_id:"1")
        expect(get: "assessor/casestudy_user/1/submit").to      route_to(controller: "assessor_responses", action: "submit_assessment", casestudy_user_id:"1")
    end

    it "routes for casestudies" do
        expect(get: "/casestudies").to          route_to(controller: "casestudies", action: "index")
        expect(post: "/casestudies").to         route_to(controller: "casestudies", action: "create")
        expect(get: "/casestudies/new").to      route_to(controller: "casestudies", action: "new")
        expect(get: "/casestudies/1/edit").to   route_to(controller: "casestudies", action: "edit", id: "1")
        expect(get: "/casestudies/1").to        route_to(controller: "casestudies", action: "show", id: "1")
        expect(patch: "/casestudies/1").to      route_to(controller: "casestudies", action: "update", id: "1")
        expect(put: "/casestudies/1").to        route_to(controller: "casestudies", action: "update", id: "1")
    end

    it "routes for casestudies/pages" do
        expect(get: "/casestudies/1/pages").to          route_to(controller: "pages", action: "index",   casestudy_id:"1")
        expect(post: "/casestudies/1/pages").to         route_to(controller: "pages", action: "create",  casestudy_id:"1")
        expect(get: "/casestudies/1/pages/new").to      route_to(controller: "pages", action: "new",     casestudy_id:"1")
        expect(get: "/casestudies/1/pages/1/edit").to   route_to(controller: "pages", action: "edit",    casestudy_id:"1", id:"1")
        expect(get: "/casestudies/1/pages/1").to        route_to(controller: "pages", action: "show",    casestudy_id:"1", id:"1")
        expect(patch: "/casestudies/1/pages/1").to      route_to(controller: "pages", action: "update",  casestudy_id:"1", id:"1")
        expect(put: "/casestudies/1/pages/1").to        route_to(controller: "pages", action: "update",  casestudy_id:"1", id:"1")
        expect(delete: "/casestudies/1/pages/1").to     route_to(controller: "pages", action: "destroy", casestudy_id:"1", id:"1")
    end

    it "routes for casestudies/questions" do
        expect(get: "/casestudies/1/questions").to          route_to(controller: "questions", action: "index",   casestudy_id:"1")
        expect(post: "/casestudies/1/questions").to         route_to(controller: "questions", action: "create",  casestudy_id:"1")
        expect(get: "/casestudies/1/questions/new").to      route_to(controller: "questions", action: "new",     casestudy_id:"1")
        expect(get: "/casestudies/1/questions/1/edit").to   route_to(controller: "questions", action: "edit",    casestudy_id:"1", id:"1")
        expect(get: "/casestudies/1/questions/1").to        route_to(controller: "questions", action: "show",    casestudy_id:"1", id:"1")
        expect(patch: "/casestudies/1/questions/1").to      route_to(controller: "questions", action: "update",  casestudy_id:"1", id:"1")
        expect(put: "/casestudies/1/questions/1").to        route_to(controller: "questions", action: "update",  casestudy_id:"1", id:"1")
        expect(delete: "/casestudies/1/questions/1").to     route_to(controller: "questions", action: "destroy", casestudy_id:"1", id:"1")
    end

    it "routes for casestudies/questions/question_traits" do
        expect(post: "/casestudies/1/questions/1/question_traits").to       route_to(controller: "question_traits", action: "create",  casestudy_id:"1", question_id:"1")
        expect(get: "/casestudies/1/questions/1/question_traits/new").to    route_to(controller: "question_traits", action: "new",     casestudy_id:"1", question_id:"1")
        expect(delete: "/casestudies/1/questions/1/question_traits/1").to   route_to(controller: "question_traits", action: "destroy", casestudy_id:"1", question_id:"1", id:"1")
    end

end