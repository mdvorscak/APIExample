module Api
  class ApiController < ApplicationController
    skip_before_filter :verify_authenticity_token
    protect_from_forgery with: :null_session
    before_filter :authenticate

    def current_user
      @current_user
    end

    def authenticate
      authenticate_or_request_with_http_basic do |username, pass|
        # user = User.find_by(username: username)
        # @current_user = user
        # user.authenticate(pass)
        username == "test" && pass == "test"
      end
    end

    def find_record_or_render_error(model, id)
      begin
        model.find(id)
      rescue ActiveRecord::RecordNotFound => e
        render status: 422, json: {
                              errors: e.message
                          }.to_json
      end
    end
  end
end