RSpec.describe ProfileRepoService do

    let(:profile_name) { 'octokit' } 

    subject { ProfileRepoService.new }

    context 'Profile_Repo_Service' do

        it "can check if profile exist(#{:profile_name})" do
            expect(subject.profile_exists(profile_name)).to be true
        end

        it "can retrieve repos from existing profile (#{:profile_name})" do
            expect(subject.get_profile_repos(profile_name)).to be_an_instance_of(Array)
        end

        it "can retrieve an array of languages - extracting language(s) from each repo - for array of repos (#{:profile_name})" do
            repos = subject.get_profile_repos(profile_name)
            expect(subject.extract_languages_from_repos(repos)).to be_an_instance_of(Array)
        end

        it "can retrieve an array of languages - extracting language(s) from each repo - for array of repos (#{:profile_name})" do
            repos = subject.get_profile_repos(profile_name)
            expect(subject.extract_languages_from_repos(repos)).to be_an_instance_of(Array)
        end

        it "can retrieve most used language from count hash" do
        hash = {"Ruby": 6, "Javascript": 3}
        expect(subject.most_used_language(hash)).to eq([:Ruby])
    end


    end

end