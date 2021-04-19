class Api::V1::ProfilesController < ApplicationController

    # GET /profiles/:id
    def show
        profile_name = params[:id]
        service = ProfileRepoService.new
        response = service.aggregate_repos_info(profile_name)
        render json: response
    end

end
