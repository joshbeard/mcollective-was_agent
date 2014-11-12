metadata :name        => "WAS",
         :description => "Interact with WebSphere profiles",
         :author      => "Josh Beard",
         :license     => "MIT",
         :version     => "1.0",
         :url         => "http://puppetlabs.com",
         :timeout     => 900

action "profile_list", :description => "Retrieve a list of profiles" do
    output :was_profiles,
           :description => "List of profiles",
           :display_as  => "Profiles",
           :default     => ""
end

action "profile_status", :description => "Retrieve the status of a profile" do
    display :always

    input :wasprofile,
          :prompt      => "Profile name",
          :description => "Specify a specific profile",
          :type        => :string,
          :validation  => '.',
          :maxlength   => 256,
          :optional    => true

    output :running,
           :description => 'Profiles that are running',
           :display_as  => 'Running',
           :default     => ''

    output :stopped,
           :description => 'Profiles that are stopped',
           :display_as  => 'Stopped',
           :default     => ''


end

action "profile_start", :description => "Start a specified profile" do
    display :always

    input :wasprofile,
          :prompt      => "Profile name",
          :description => "Specify a specific profile",
          :type        => :string,
          :validation  => '.',
          :maxlength   => 256,
          :optional    => true

    output :results,
           :description => 'Result of starting',
           :display_as  => 'Result',
           :default     => ''

end

action "profile_stop", :description => "Stop a specified profile" do
    display :always

    input :wasprofile,
          :prompt      => "Profile name",
          :description => "Specify a specific profile",
          :type        => :string,
          :validation  => '.',
          :maxlength   => 256,
          :optional    => true

    output :results,
           :description => 'Result of starting',
           :display_as  => 'Result',
           :default     => ''

end
# vim: set syntax=ruby:
