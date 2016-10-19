# Disallow insecure protocols
describe package('telnetd') do
  it { should_not be_installed }
end

describe inetd_conf do
  its('telnet') { should eq nil }
end

describe port(8484) do
  it { should be_listening }
end

describe port(80) do
  it { should_not be_listening }
end

describe port(443) do
  it { should_not be_listening }
end

# is Chef installed?
describe package('chef') do
  it { should be_installed }
  its('version') { should match (/12\.\d+\.\d+/) }
end

# is GO lang installed?
describe command('/usr/local/go/bin/go version') do
 its('stdout') { should match (/go version go\d+.\d+.\d+ linux\/amd64/) }
ends

# is Datadog installed?
#describe package('datadog-agent') do
#  it { should be_installed }
#  its('version') { should match (/5\.\d+\.\d+/)}
#end

#describe service('datadog-agent') do
#  it { should be_enabled }
#end
