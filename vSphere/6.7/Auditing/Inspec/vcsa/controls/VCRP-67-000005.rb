control "VCRP-67-000005" do
  title "rhttpproxy must produce log records containing sufficient information
to establish the source of events."
  desc  "After a security incident has occurred, investigators will often
review log files to determine what happened and determining the source of an
event is crucial for forensics. rhttpproxy must be configured for verbose
logging in order to capture client IP addresses and the associated actions."
  impact 0.5
  tag severity: "CAT II"
  tag gtitle: "SRG-APP-000016-WSR-000005"
  tag gid: nil
  tag rid: "VCRP-67-000005"
  tag stig_id: "VCRP-67-000005"
  tag fix_id: nil
  tag cci: "CCI-000067"
  tag nist: ["AC-17 (1)", "Rev_4"]
  tag false_negatives: nil
  tag false_positives: nil
  tag documentable: nil
  tag mitigations: nil
  tag severity_override_guidance: nil
  tag potential_impacts: nil
  tag third_party_tools: nil
  tag mitigation_controls: nil
  tag responsibility: nil
  tag ia_controls: "AC-17 (1)"
  tag check: "At the command prompt, execute the following command:

# grep \"<level>\" /etc/vmware-rhttpproxy/config.xml"
  tag fix: "Navigate to and open /etc/vmware-rhttpproxy/config.xml

Locate the <log> block and configure <level> as follows:

<level>verbose</level>

Restart the service for changes to take effect.

# vmon-cli --restart rhttpproxy"

  describe xml('/etc/vmware-rhttpproxy/config.xml') do
    its(['/config/log/level']) { should cmp ['verbose'] }
  end

end