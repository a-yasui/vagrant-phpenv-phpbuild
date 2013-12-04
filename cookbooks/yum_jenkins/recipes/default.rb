# execute "Install Jenkins repo" do
remote_file "/etc/yum.repos.d/jenkins.repo" do
  source "http://pkg.jenkins-ci.org/redhat/jenkins.repo"
  mode 0644
  action :create_if_missing
end
execute "Install Jenkins repo" do
  command "rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key"
end

# yum_repository method is over >= 1.6 at chef.
# yum_repository "Jenkins" do
#   description "Jenkins Stable repo"
#   url "http://pkg.jenkins-ci.org/redhat/jenkins.repo"
#   key "RPM-GPG-KEY-zenoss"
#   action :add
# end
# key "RPM-GPG-KEY-jenkins" do
#   url "http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key"
#   action :add
# end

%w{java-1.7.0-openjdk jenkins}.each do |name|
  package name do
    action :install
  end
end

service "jenkins" do
  action [:start, :enable]
end

