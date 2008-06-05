uci_applied = "The following changes have been applied"
uci_reverted = "The following changes have been reverted"

a_i_ui = "User Interface"

c_lucidesc = [[LuCI is a free Lua library with integrated MVC-Webframework and webinterface for embedded devices,
aspecially routers that run OpenWRT. Luci is licensed under the Apache-License.]]
c_projecthome = "Project Homepage"
c_leaddev = "Lead Development"
c_contributors = "Contributing Developers"
c_thanksto = "Thanks To"

a_i_i_hello = "Hello!"
a_i_i_admin1 = "This is the administration area of LuCI."
a_i_i_admin2 = "LuCI is a free, flexible, and user friendly graphical interface for configuring OpenWRT Kamikaze."
a_i_i_admin3 = "On the following pages you can adjust all important settings of your router."
a_i_i_admin4 = "You will find a navigation leading to the different configuration pages on the left side."
a_i_i_admin5 = [[As we are always want to improve this interface we are looking forward
to your feedback and suggestions.]]
a_i_i_admin6 = "And now have fun with your router!"
a_i_i_team   = "The LuCI Team"

a_i_luci1 = "Here you can customize the settings and the functionality of LuCI."
a_i_ucicommit = "Post-commit actions"
a_i_ucicommit1 = [[These commands will be executed automatically when a given UCI configuration is committed allowing
changes to be applied instantly.]]
a_i_keepflash = "Files to be kept when flashing a new firmware"
a_i_keepflash1 = "When flashing a new firmware with LuCI these files will be added to the new firmware installation."

a_st_i_status1 = [[Here you can find information about the current system status like CPU clock frequency, memory
usage or network interface data.]]
a_st_i_status2 = [[Also kernel or service logfiles can be viewed here to get an overview over their current state.]]

a_s_packages = "Software"
a_s_changepw = "Admin Password"
a_s_p_ipkg = "IPKG-Configuration"
a_s_sshkeys = "SSH-Keys"
a_s_fstab = "Mount Points"
a_s_flash = "Flash Firmware"

a_s_i_system1 = [[Change settings related to the system itself, its identification,
installed hard- and software, authentication or mount points.]]
a_s_i_system2 = [[These settings define the base of your system.]]
a_s_i_system3 = [[Pay attention as any misconfiguration here may prevent your device from booting
or may lock yourself out of it.]]

a_s_packages_do = "Perform Actions"
a_s_packages_install = "Install"
a_s_packages_installurl = "Download and install package"
a_s_packages_ipkg = "Edit package lists and installation targets"
a_s_packages_name = "Paketname"
a_s_packages_remove = "Remove"
a_s_packages_search = "Find package"
a_s_packages_update = "Package lists updated"
a_s_packages_updatelist = "Update package lists"
a_s_packages_upgrade = "Upgrade installed packages"

a_s_p_ipkg_pkglists = "Package lists"
a_s_p_ipkg_targets = "Installation targets"

a_s_changepw1 = "Change the password of the system administrator (User \"root\")"
a_s_changepw_changed = "Password successfully changed"
a_s_changepw_nomatch = "Error: Passwords do not match"

a_s_sshkeys1 = "Here you can paste public SSH-Keys (one per line) for SSH public-key authentication."

a_s_hostname1 = "Defines the router's hostname. The hostname is a unique name in your local network used to identify the device" 

a_s_fstab_mountpoints = "Mount Points"
a_s_fstab_mountpoints1 = "Mount Points define at which point a memory device will be attached to the filesystem"

a_s_fstab_mountpoint = "Mount Point"
a_s_fstab_device1 = "The device file of the memory or partition (e.g. /dev/sda1)"
a_s_fstab_fs1 = "The filesystem that was used to format the memory (e.g. ext3)"
a_s_fstab_swap1 = [[If your physical memory is insufficient unused data can be temporarily swapped
to a swap-device resulting in a higher amount of usable RAM. Be aware that swapping data is a very slow process
as the swap-device cannot be accessed with the high datarates of the RAM.]]

a_s_flash_flashed = "Firmware successfully flashed. Rebooting device..."
a_s_flash_flasherr = "Failed to flash"
a_s_flash_fwimage = "Firmwareimage"
a_s_flash_fwupgrade = "Flash Firmware"
a_s_flash_keepcfg = "Keep configuration files"
a_s_flash_notimplemented = "Sorry, this function is not (yet) available for your platform."
a_s_flash_upgrade1 = "Replaces the installed firmware with a new one. The firmware format is platform-dependent."

a_s_reboot1 = "Reboots the operating system of your device"
a_s_reboot_do = "Perform reboot"
a_s_reboot_running = "Please wait: Device rebooting..."

a_srv_http = "HTTP-Server"
a_srv_ssh = "SSH-Server"

a_srv_services1 = "Services and daemons perform certain tasks on your device."
a_srv_services2 = [[Most of them are network servers, that offer a certain service for your device or network like
shell access, serving webpages like LuCI, doing mesh routing, sending e-mails, ...]]

a_srv_http1 = "A small webserver which can be used to serve LuCI." 
a_srv_http_authrealm = "Authentication Realm"
a_srv_http_authrealm1 = "The realm which will be displayed at the authentication prompt for protected pages."
a_srv_http_config1 = "defaults to /etc/httpd.conf"
a_srv_http_root = "Document root"

a_srv_dropbear1 = "Dropbear offers SSH network shell access and an integrated SCP server"
a_srv_d_pwauth = "Password authentication"
a_srv_d_pwauth1 = "Allow SSH password authentication"

a_w_wifi1 = [[On this pages you find confiugration options for WLAN based wireless networks.]]
a_w_wifi2 = [[You can easily integrate your 802.11a/b/g/n-devices into your physical network and use
the virtual adapter support to build wireless repeaters or offer several networks with one device.]]
a_w_wifi3 = [[There is support for Managed, Client, Ad-Hoc and WDS operating modes as well as
WPA and WPA2 encryption for secure communnication.]] 

a_w_devices1 = "Here you can configure installed wifi devices."
a_w_channel  = "Channel"
a_w_txantenna = "Transmit Antenna"
a_w_rxantenna = "Receive Antenna"
a_w_distance1 = "Distance to furthest station (m)" 
a_w_diversity = "Diversity"
a_w_countrycode = "Country Code"
a_w_connlimit = "Connection Limit"

a_w_networks1 = [[You can run several wifi networks with one device. Be aware that there are certain
hardware and driverspecific restrictions. Normally you can operate 1 Ad-Hoc or up to 3 Master-Mode and 1 Client-Mode
network simultaneously.]]
a_w_netid = "Network Name (ESSID)"
a_w_network1 = "Add the Wifi network to physical network"
a_w_txpwr = "Transmit Power"
a_w_brcmburst = "Broadcom Frameburst"
a_w_athburst = "Atheros Frameburst"
a_w_radiussrv = "Radius-Server"
a_w_radiusport = "Radius-Port"
a_w_apisolation = "AP-Isolation"
a_w_apisolation1 = "Prevents Client to Client communication"
a_w_hideessid = "Hide ESSID"
