control "VCRP-67-000008" do
  title "rhttproxy must exclusively use the HTTPS protocol for client
connections."
  desc  "Remotely accessing vCenter via the rhttpproxy involves sensitive
information going over the wire. To protect the confidentiality and integrity
of these communications, the rhttpproxy must be configured to use an encrypted
session of HTTPS rather than plain-text HTTP."
  impact 0.5
  tag severity: "CAT II"
  tag gtitle: "SRG-APP-000315-WSR-000003"
  tag gid: nil
  tag rid: "VCRP-67-000008"
  tag stig_id: "VCRP-67-000008"
  tag fix_id: nil
  tag cci: "CCI-002314"
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

# sed -n \"/^  <ssl>/,/ssl>/p\" /etc/vmware-rhttpproxy/config.xml|grep -E -z
--color=always '<privateKey|<certificate|<vecsServerName'

Expected Output:

<ssl>
    <!-- The server private key file -->
    <privateKey>/etc/vmware-rhttpproxy/ssl/rui.key</privateKey>
    <!-- The server side certificate file -->
    <certificate>/etc/vmware-rhttpproxy/ssl/rui.crt</certificate>
    <!-- vecs server name. Currently vecs runs on all node types. -->
    <vecsServerName>localhost</vecsServerName>
  </ssl>

If the returned output does not match the expected output, this is a finding.
"
  tag fix: "Navigate to and open /etc/vmware-rhttpproxy/config.xml

Locate the first <ssl> block and configure <protocols> as follows:

  <ssl>
    <!-- The server private key file -->
    <privateKey>/etc/vmware-rhttpproxy/ssl/rui.key</privateKey>
    <!-- The server side certificate file -->
    <certificate>/etc/vmware-rhttpproxy/ssl/rui.crt</certificate>
    <!-- vecs server name. Currently vecs runs on all node types. -->
    <vecsServerName>localhost</vecsServerName>
  </ssl>

Restart the service for changes to take effect.

# vmon-cli --restart rhttpproxy"

  describe xml('/etc/vmware-rhttpproxy/config.xml') do
    its(['/config/ssl/privateKey']) { should cmp ['/etc/vmware-rhttpproxy/ssl/rui.key'] }
    its(['/config/ssl/certificate']) { should cmp ['/etc/vmware-rhttpproxy/ssl/rui.crt'] }
    its(['/config/ssl/vecsServerName']) { should cmp ['localhost'] }
  end

end