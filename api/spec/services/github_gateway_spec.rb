RSpec.describe GithubGateway do

    let(:profile_name) { 'octokit' } 

    context 'Oktokit Gem' do

        let(:access_token){Rails.application.credentials.dig(:github, :access_token)}
        let(:client){Octokit::Client.new(:access_token => access_token)}

        it "can connect to a github profile (#{:profile_name})" do
            user = client.user profile_name
            expect(user["login"]).to include (profile_name)
        end

        it 'can retrieve repos from a github profile (#{:profile_name}) ' do
            repos = client.repositories(profile_name, {sort: :pushed_at})
            expect(repos).to be_an_instance_of(Array)
        end

    end
 
    context 'GithubGateway' do   

        let(:adapter){GithubGateway.new}
        
        it "can check if profile exists (#{:profile_name})" do
            expect(adapter.profile_exists(profile_name)).to be true
        end

        it "can retrieve repos from existing profile (#{:profile_name})" do
            expect(adapter.get_profile_repos(profile_name)).to be_an_instance_of(Array)
        end

        it "can retrieve repos from existing profile (#{:profile_name})" do
        expect(adapter.get_profile_repos(profile_name)).to be_an_instance_of(Array)
    end

    end

end