require 'serverspec'

# Required by serverspec
set :backend, :exec

describe service('rsyslog'), :if => (os[:family] == 'ubuntu' && os[:release] != '16.04') || (os[:family] == 'redhat' && os[:release] != '7') do
  it { should be_enabled }
end
describe service('rsyslog') do
  it { should be_running }
end

describe file('/usr/sbin/rsyslogd') do
  it { should be_executable }
end

describe process("rsyslogd") do
  its(:user) { should eq "syslog" }
end

describe file('/var/log/syslog'), :if => os[:family] == 'ubuntu' do
  it { should be_file }
end

describe file('/var/log/messages'), :if => os[:family] == 'redhat' do
  it { should be_file }
end
