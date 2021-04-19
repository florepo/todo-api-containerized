class ProfileRepoService

    def initialize
        @adapter = GithubGateway.new
    end

    def aggregate_repos_info(profile_name)
        profile_data = {}
        response = {}
        if (profile_exists(profile_name))       
            repos_array = get_profile_repos(profile_name)
            profile_data['languages'] = get_repos_language_count(repos_array)
            profile_data["most_used_language"] = most_used_language(profile_data['languages'])
            profile_data["total_repos"] = repos_array.length
            response["data"] = profile_data
            response["status"] = "ok"
        else
            response["status"]= "error: profile name does not exist"
        end
        return response
    end

    def profile_exists(profile_name)
        @adapter.profile_exists(profile_name)
    end 

    def get_profile_repos(profile_name)
        repos_array = @adapter.get_profile_repos(profile_name)
        return repos_array
    end

    def get_repos_language_count(repos_array)
        language_count = Hash.new
        repo_languages_array = extract_languages_from_repos(repos_array)

        repo_languages_array.each do |language|
            !language_count[language] ? language_count[language] = 1 : language_count[language] += 1
        end

        return language_count 
    end

    def extract_languages_from_repos(repos_array)
        repo_languages = []
        repos_array.each do |repo|
            repo_languages << repo[:language]
        end
        return repo_languages.flatten
    end

    def most_used_language(language_count_hash)
        most_used = Hash.new
        max_value = language_count_hash.values.max
        languages = language_count_hash.select{|k, v| v == max_value}.keys
        languages.compact
    end

end