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
