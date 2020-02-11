salt_version = 
  case input('salt_version')
  when 'master', 'latest'
    '3000'
  else
    input('salt_version')
  end
python_version = input('py_version') == '3' ? '3' : '2'

control 'salt call' do
  title 'should be installed'

  describe command('salt-call --version') do
    its('stdout') { should match /#{salt_version}/ }
    its('exit_status') { should eq 0 }
  end
end

control 'salt packages' do
  title 'should be using the desired python'

  describe command('salt-call --versions-report') do
    its('stdout') { should match /Python: #{python_version}/ }
    its('exit_status') { should eq 0 }
  end
end
