require 'docker'
require 'spec_helper'

describe 'Docker image building' do
  context 'when validating host software' do
    it 'should supported version' do
      expect { Docker.validate_version! }.to_not raise_error
    end
  end

  context 'when building image' do
    subject { Docker::Image.build_from_dir '.' }

    it { is_expected.to_not be_nil }
    it { is_expected.to have_exposed_port tcp: 7990 }
    it { is_expected.to_not have_exposed_port udp: 7990 }
    it { is_expected.to have_exposed_port tcp: 7999 }
    it { is_expected.to_not have_exposed_port udp: 7999 }
    it { is_expected.to have_volume '/var/local/atlassian/stash' }
    it { is_expected.not_to have_volume '/usr/local/atlassian/stash' }
    it { is_expected.to have_working_directory '/var/local/atlassian/stash' }
  end
end
