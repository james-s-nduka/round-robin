describe command('curl localhost') do
  its('stdout') { should match /Hi there, I'm served from ip-\d+\-\d+\-\d+\-\d+/ }
end

describe port(80) do
  it { should be_listening }
end

# is Chef installed?

# is GO lang installed

# is Datadog installed?

# are any user accounts enabled that shouldn't be?
