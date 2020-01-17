require 'spec_helper'

describe 'sonarqube::runner::install' do
  let(:params) {{
    :package_name => 'sonar-runner',
    :version => '2.4',
    :download_url => 'http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist',
    :installroot => '/usr/local',
  }}

  context "check directory link" do
    it { should contain_file('/usr/local/sonar-runner') }
  end
end
