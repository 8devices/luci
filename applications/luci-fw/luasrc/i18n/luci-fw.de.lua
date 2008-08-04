fw_portfw = "Portweiterleitung"
fw_forwarding = "Weiterleitung"
fw_fw = "Firewall"
fw_zone = "Zone"
fw_zones = "Zonen"
fw_custfwd = "Eigene Weiterleitungen"
fw_rules = "Eigene Regeln"
fw_rules1 = "An dieser Stelle können benutzerdefinierte Firewallregeln eingestellt werden um den Netzverkehr zu kontrollieren."
fw_fw1 = "Die Firewall erstellt Netzwerkzonen über bestimmte Netzwerkschnittstellen um den Netzverkehr zu trennen."
firewall_rule_src = "Eingangszone"
firewall_rule_dest = "Ausgangszone"
firewall_rule_srcip = "Quelladresse"
firewall_rule_destip = "Zieladresse"
firewall_rule_srcmac = "Quell-MAC-Adresse"
firewall_rule_srcport = "Quellport"
firewall_rule_destport = "Zielport"
firewall_rule_target = "Aktion"
fw_accept = "annehmen"
fw_reject = "zurückweisen"
fw_drop = "verwerfen"

fw_portfw1 = [[Portweiterleitungen ermöglichen es interne Netzwerkdienste aus einem externen Netzwerk heraus erreichbar zu machen.]]
firewall_redirect_src_desc = "Externe Zone"
firewall_redirect_srcdport = "Externer Port"
firewall_redirect_srcdport_desc = "Port od. Erster:Letzter Port"
firewall_redirect_destip = "Interne Adresse"
firewall_redirect_destip_desc = "IP-Adresse"
firewall_redirect_destport = "Interner Port (optional)"
firewall_redirect_destport_desc = "Port od. Erster:Letzter Port"
firewall_redirect_srcip = firewall_rule_srcip
firewall_redirect_srcmac = firewall_rule_srcmac
firewall_redirect_srcport = firewall_rule_srcport

fw_forwarding1 = [[An dieser Stelle kann festgelegt zwischen welchen Zonen Netzverkehr hin und her fließen kann.
Es werden nur neue Verbindungen betrachtet. Pakete, die zu bereits bestehenden Verbindungen gehören werden automatisch
akzeptiert.]]
firewall_forwarding_src = "Eingang"
firewall_forwarding_src_desc = firewall_rule_src
firewall_forwarding_dest = "Ausgang" 
firewall_forwarding_dest_desc = firewall_rule_dest

firewall_defaults = "Grundeinstellungen"
firewall_defaults_desc = "Grundeinstellungen die verwendet werden, wenn keine andere Regel angewandt werden kann."
firewall_defaults_synflood = "Schutz vor SYN-flood-Attacken"
firewall_defaults_input = "Eingehender Verkehr"
firewall_defaults_output = "Ausgehender Verkehr"
firewall_defaults_forward = "Weitergeleiteter Verkehr"

firewall_zone_desc = [[Zonen teilen das Netzwerk in mehrere Bereiche ein um Netzverkehr sicher zu trennen.
Ein oder mehrere Netzwerke gehören zu einer Zone.
Das MASQ-Flag legt fest, dass aller ausgehende Netzverkehr einer Zone NAT-maskiert wird.]]
firewall_zone_input = "Eingehender Verkehr"
firewall_zone_input_desc = "Standardaktion"
firewall_zone_output = "Ausgehender Verkehr"
firewall_zone_output_desc = "Standardaktion"
firewall_zone_forward = "Weitergeleiteter Verkehr"
firewall_zone_forward_desc = "Standardaktion"
firewall_zone_masq = "MASQ"
firewall_zone_network = "Netzwerke"
firewall_zone_network_desc = "verbundene Netzwerke"