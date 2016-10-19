describe command('curl localhost') do
  its('stdout') { should match /Hi there, I'm served from ip-\d+\-\d+\-\d+\-\d+/ }
end

describe port(80) do
  it { should be_listening }
end

# is Chef installed?
describe package('chef') do
  it { should be_installed }
  its('version') { should match (/12\.\d+\.\d+/) }
end

# is GO lang installed
