class GithubGateway

    def initialize
        @access_token = Rails.application.credentials.dig(:github, :access_token)
        @client = Octokit::Client.new(:access_token => @access_token)
        @client.auto_paginate = true
    end

    def profile_exists(profile_name)
        begin
            user = @client.user profile_name
            user ? true : false
        rescue
            puts("profile does not exist")
        end
          
    end

    def get_profile_repos(profile_name)
        repos = @client.repositories(profile_name, {sort: :pushed_at})
        return repos
    end

end