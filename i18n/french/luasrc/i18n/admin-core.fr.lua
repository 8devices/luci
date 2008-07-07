uci_applied = "Les changements suivants ont �t� appliqu�s"
uci_reverted = "Les changements suivants ont �t� annul�s"

a_i_ui = "Interface utilisateur"

c_lucidesc = [[LuCI est une suite logicielle d'applications Lua software incluant un MVC-Webframework et une interface web pour �quipements embarqu�s.
Luci est sous license Apache.]]
c_projecthome = "Page d'accueil du projet"
c_leaddev = "D�veloppeurs principaux"
c_contributors = "Contributeurs"
c_thanksto = "Merci �"

a_i_i_hello = "Bonjour !"
a_i_i_admin1 = "Voici la page d'administration de LuCI."
a_i_i_admin2 = "LuCI est une interface graphique libre, flexible, et user friendly pour configurer OpenWRT Kamikaze."
a_i_i_admin3 = "Dans les pages suivantes vous pouvez ajuster tous les r�glages importants de votre routeur."
a_i_i_admin4 = "Vous trouverez une page de navigation sur le c�t� gauche permettant d'acc�der aux diff�rentes pages de configuration."
a_i_i_admin5 = [[Nous souhaitons am�liorer l'interface de mani�re permanente, vos retours et suggestions sont primordiaux.]]
a_i_i_admin6 = "Et maintenant que la f�te commence !"
a_i_i_team   = "L'�quipe LuCI"

a_i_luci1 = "Ici, vous pouvez personnaliser les r�glages et les fonctionnalit�s de LuCI."
a_i_ucicommit = "Actions post-changements"
a_i_ucicommit1 = [[Ces commandes seront execut�es automatiquement lorsqu'une configuration UCI est appliqu�e, les changement prenant
effet imm�diatement.]]
a_i_keepflash = "Fichiers � conserver lors d'une mise � jour du firmware"
a_i_keepflash1 = "Lors d'une nouvelle installation, ces fichiers seront ajout�s � la nouvelle installation."

a_st_i_status1 = [[Ici, vous trouverez des informations sur l'�tat actuel du syst�me comme la fr�quence processeur, utilisation m�moire et
trafic r�seau.]]
a_st_i_status2 = [[Les journaux des services ou du noyau peuvent �tre vus ici afin d'obtenir un aper�u de leur �tat.]]

iwscan = "Scan WLAN"
iwscan1 = "R�seaux Wi-Fi dans votre environnement"
iwscan_encr = "Chiffrement"
iwscan_link = "Lien"
iwscan_signal = "Signal"
iwscan_noise = "Bruit"

routes = "Routes"
routes_netmask = "Masque r�seau"
routes_gateway = "Passerelle"
routes_metric = "Metrique"

a_s_packages = "Software"
a_s_changepw = "Mot de passe administrateur"
a_s_p_ipkg = "Configuration IPKG"
a_s_sshkeys = "Cl�s SSH"
a_s_fstab = "Points de montage"
a_s_flash = "Mise � jour firmware"

a_s_i_system1 = [[Changements en rapport avec le syst�me, son identification
le logiciel/mat�riel install�, l'authentification ou points de montage.]]
a_s_i_system2 = [[Ces r�glages d�finissent la base de votre syst�me.]]
a_s_i_system3 = [[Soyez vigilent car un mauvais r�glage peut emp�cher votre �quipement de d�marrer,
ou vous emp�cher de vous y connecter.]]

a_s_packages_do = "Accomplir les actions"
a_s_packages_install = "Installer"
a_s_packages_installurl = "T�l�charge et installe le paquet"
a_s_packages_ipkg = "Editer la liste des paquets et le r�pertoire de destination"
a_s_packages_name = "Nom du paquet"
a_s_packages_remove = "D�sinstaller"
a_s_packages_search = "Trouver un paquet"
a_s_packages_update = "Liste des paquets mise � jour"
a_s_packages_updatelist = "Mettre � jour la liste des paquets"
a_s_packages_upgrade = "Mettre � jour les paquets install�s"

a_s_p_ipkg_pkglists = "Listes de paquets"
a_s_p_ipkg_targets = "R�pertoires de destination"

a_s_changepw1 = "Changer le mot de passe du syst�me (Utilisateur \"root\")"
a_s_changepw_changed = "Mot de passe chang� avec succ�s"
a_s_changepw_nomatch = "Erreur: les mots de passe ne correspondent pas"

a_s_sshkeys1 = "Vous pouvez copier ici des cl�s SSH publiques (une par ligne) pour une authentification SSH sur cl�s publiques."

a_s_fstab_mountpoints = "Points de montage"
a_s_fstab_mountpoints1 = "Les points de montage d�finissent l'attachement d'un p�riph�rique au syst�me de fichier."

a_s_fstab_mountpoint = "Point de montage"
a_s_fstab_device1 = "Le p�riph�rique de bloc contenant la partition (ex : /dev/sda1)"
a_s_fstab_fs1 = "Le syst�me de fichiers utilis� pour formatter le support de stockage (ex : ext3)"
a_s_fstab_swap1 = [[Si la m�moire physique n'est pas en quantit� suffisante, les donn�es inutilis�es peuvent �tre
temporairement transf�r�e sur une partition d'�change, relevant la quantit� de RAM disponible.
Ce processus est lent car la m�moire d'�change ne peut �tre acc�d�e aux taux de transfert
de la RAM.]]

a_s_flash_flashed = "Firmware install� avec succ�s. R�d�marrage..."
a_s_flash_flasherr = "Programme lors de la programmation"
a_s_flash_fwimage = "Image firmware"
a_s_flash_fwupgrade = "Mise � jour firmware"
a_s_flash_keepcfg = "Conserver les fichiers de configuration"
a_s_flash_notimplemented = "D�sol�, cette fonction n'est pas (encore) disponible pour votre plateforme."
a_s_flash_upgrade1 = "Remplace les fichiers existants par les nouveaux. Le format du firmware est d�pendant de la plateforme."

a_s_reboot1 = "R�dmarrage du syst�me d'exploitation de votre �quipement"
a_s_reboot_do = "R�d�marrer"
a_s_reboot_running = "Patientez s'il vous pla�t: �quipement en cours de r�d�marrage..."

a_srv_http = "Serveur HTTP"
a_srv_ssh = "Serveur SSH"

a_srv_services1 = "Les services et d�mons accomplissent certaines t�ches sur votre �quipement."
a_srv_services2 = [[La plupart d'entre eux sont des serveurs r�seaux, qui vous offrent certains services comme
un acc�s shell, acc�der � des pages comme LuCI, faire du routage mesh, envoyer des e-mails ...]]

a_srv_http1 = "Un serveur web l�ger qui peut �tre utilis� pour LuCI."
a_srv_http_authrealm = "Domaine d'authentification"
a_srv_http_authrealm1 = "Le domaine qui sera affich� lors de la fen�tre d'authentification."
a_srv_http_config1 = "fichier de configuration par d�faut : /etc/httpd.conf"
a_srv_http_root = "Page racine"

a_srv_dropbear1 = "Dropbear est un serveur SSH et int�gre un serveur SCP"
a_srv_d_pwauth = "Authentification par mot de passe"
a_srv_d_pwauth1 = "Autoriser l'authentification SSH par mot de passe"

a_w_wifi1 = [[Dans cette page vous trouverez des options de configuration pour les r�seau sans-fils.]]
a_w_wifi2 = [[Vous pouvez facilement installer un p�riph�rique 802.11a/b/g/n dans votre r�seau physique existant
et utiliser la gestion des interfaces virtuelles pour cr�er des r�p�teurs sans-fils ou fournir plusieurs
r�seaux avec un seul �quipement.]]
a_w_wifi3 = [[Les modes Point d'acc�s, Station, Ad-Hoc et WDS coupl�s aux chiffrements WPA et WPA2
sont g�r�s.]] 

a_w_devices1 = "Ici vous pouvez configurer les �quipements Wi-Fi install�s."
a_w_channel  = "Canal"
a_w_txantenna = "Antenne transmission"
a_w_rxantenna = "Antenne r�ception"
a_w_distance1 = "Distance vers la station la plus �loign�e (m)" 
a_w_diversity = "Diversit�"
a_w_countrycode = "Code pays"
a_w_connlimit = "Limite de connexion"

a_w_networks1 = [[Vous pouvez faire fonctionner plusieurs r�seaux Wi-Fi sur un seul �quipement.
Il existe des limitations mat�rielles et li�es au pilote. En g�n�ral vous pouvez faire fonctionner simultan�ment
1 r�seau Ad-Hoc et 3 points d'acc�s simultan�ment.]]
a_w_netid = "Nom du r�seau (ESSID)"
a_w_network1 = "Ajouter ce r�seau Wi-Fi au r�seau physique"
a_w_txpwr = "Puissance d'�mission"
a_w_brcmburst = "Technologie Broadcom Frameburst"
a_w_athburst = "Technologie Atheros Frameburst"
a_w_radiussrv = "Serveur Radius"
a_w_radiusport = "Port Radius"
a_w_apisolation = "Isolation AP"
a_w_apisolation1 = "Emp�che la communication directe Client � Client"
a_w_hideessid = "Cacher le ESSID"

dhcp_desc = "Dnsmasq est un serveur DHCP combin� � un requ�teur DNS pour les pare-feu NAT"
dhcp_dnsmasq_domainneeded = "Domain requis"
dhcp_dnsmasq_domainneeded_desc = "Ne pas transmettre de requ�tes DNS sans nom DNS"
dhcp_dnsmasq_authoritative = "Authoritaire"
dhcp_dnsmasq_authoritative_desc = "C'est le seul serveur DHCP sur le r�seau local"
dhcp_dnsmasq_boguspriv = "Filtrer les requ�tes priv�es"
dhcp_dnsmasq_boguspriv_desc = "Ne pas transmettre les requ�tes de recherche inverse pour les r�seaux locaux"
dhcp_dnsmasq_filterwin2k = "Filtrer les requ�tes inutiles"
dhcp_dnsmasq_filterwin2k_desc = "filtre les requ�tes inutiles �mises par les syst�mes Windows"
dhcp_dnsmasq_localisequeries = "Localiser les requ�tes"
dhcp_dnsmasq_localisequeries_desc = "localiser la r�ponse suivant l'�metteur de la requ�te"
dhcp_dnsmasq_local = "Serveur local"
dhcp_dnsmasq_domain = "Domaine local"
dhcp_dnsmasq_expandhosts = "Etendre le nom d'h�te"
dhcp_dnsmasq_expandhosts_desc = "concat�ne le nom de domaine aux noms d'h�tes"
dhcp_dnsmasq_nonegcache = "ne pas mettre en cache les requ�tes n�gatives"
dhcp_dnsmasq_nonegcache_desc = "emp�che la mise en cache de requ�tes DNS erronn�es"
dhcp_dnsmasq_readethers = "Utiliser /etc/ethers"
dhcp_dnsmasq_readethers_desc = "Lire /etc/ethers pour configurer le serveur DHCP" 
dhcp_dnsmasq_leasefile = "Fichier de baux"
dhcp_dnsmasq_leasefile_desc = "fichier dans lequel les baux DHCP seront stock�s"
dhcp_dnsmasq_resolvfile = "Fichier de r�solution"
dhcp_dnsmasq_resolvfile_desc = "fichier de r�solution local"
dhcp_dnsmasq_nohosts = "Ignorer /etc/hosts"
dhcp_dnsmasq_strictorder = "Ordre stricte"
dhcp_dnsmasq_strictorder_desc = "Les serveurs DNS du fichier de r�solution seront interrog�s dans l'ordre"
dhcp_dnsmasq_logqueries = "Journaliser les requ�tes"
dhcp_dnsmasq_noresolv = "Ignorer le fichier de r�solution"
dhcp_dnsmasq_dnsforwardmax = "Requ�tes concurrentes maximum"
dhcp_dnsmasq_port = "Port DNS"
dhcp_dnsmasq_ednspacket_max = "taille maximum du paquet. EDNS.0 "
dhcp_dnsmasq_dhcpleasemax = "baux maximum"
dhcp_dnsmasq_addnhosts = "fichiers de noms d'h�tes suppl�mentaires"
dhcp_dnsmasq_queryport = "port de requ�te"

a_n_switch = "Switch"
a_n_routes = "Routes"

a_network1 = "Dans cette section vous trouverez tous les r�glages relatifs au r�seau."
a_network2 = "Sur la plupart des routeurs, les ports des switchs peuvent �tre configur�s et s�par�s en plusieurs VLANs."
a_network3 = "Les r�glages des interfaces et du PPPoE / PPTP vous permettent une configuration personalis�e du r�seau."
a_network4 = "Les �quipements utilisant DHCP dans votre r�seau local peuvent �tre configur�s automatique pour l'acc�s au r�seau."
a_network5 = "Le pare-feu et la redirection de ports peuvent �tre utilis�s pour fournir un service interne � un r�seau ext�rieur."

a_n_switch1 = [[Les ports de votre routeur peuvent �tre configur�s pour combiner plusieurs VLANs
dans lesquels les machines connect�es peuvent dialoguer directement l'une avec l'autre.
Les VLANs sont souvent utilis�s pour s�parer diff�rences sous-r�seaux.
Bien souvent il y a un port d'uplink pour une connexion vers un r�seau plus vaste, comme internet
et les autres ports sont r�serv�s au r�seau local.]]
network_switch_desc = [[Les ports appartenant � un VLAN sont s�par�s par des espaces.
Le port ayant le num�ro le plus �lev� (5 en g�n�ral) est souvent connect� � l'interface interne du routeur.
Les �quipements avec 5 ports ont souvent leur port 0 comme port d'uplink par d�faut.]]

a_n_ifaces1 = [[Dans cette page vous pourrez configurer les interfaces r�seaux.
Vous pouvez bridger diff�rentes interfaces en cochantt le champ "bridger les interfaces"
et en saisissant les noms des interfaces r�seau s�par�es par des espaces
Vous pouvez aussi utiliser la notation VLAN, INTERFACE.VLANNB (ex : eth0.1).]]
a_n_i_bridge = "Bridger les interfaces"
a_n_i_bridge1 = "cr�er un bridge entre plusieurs interfaces"

dhcp_desc = [[Avec DHCP, les machines connect�es au r�seau peuvent recevoir leurs r�glages
r�seau directement (adresse IP, masque de r�seau, serveur DNS, ...)]]
dhcp_dhcp_leasetime = "Dur�e du bail"
dhcp_dhcp_dynamicdhcp = "DHCP dynamique"
dhcp_dhcp_ignore = "Ignorer l'interface"
dhcp_dhcp_ignore_desc = "d�sactiver DHCP sur cette interface"
dhcp_dhcp_force = "Forcer"
dhcp_dhcp_start_desc = "premi�re addresse (dernier octet)"
dhcp_dhcp_limit_desc = "nombre d'adresses disponibles - 1"

a_n_ptp = "Connexions Point-�-Point"
a_n_ptp1 = [[Les connexions Point-�-Point en PPPoE ou PPTP sont souvent utilis�es pour
connecter un �quipement � internet sur du DSL ou une technologie similaire.]]
network_interface_server = "Serveur PPTP"
network_interface_demand = "D�connexion automatique"
network_interface_demand_desc = "D�lai d'inactivit� � partir duquel la connexion est coup�e"
network_interface_keepalive = "Maintenir la connexion"
network_interface_keepalive_desc = "Reconnexion si la connexion est perdue"

a_n_routes = "Routes stattiques"
a_n_routes1 = [[Avec les routes statiques vous pouvez sp�cifier
� travers quelle interface ou passerelle un r�seau peut �tre contact�.]]
a_n_r_target1 = "adresse IP ou r�seau"
a_n_r_netmask1 = "si la destination est un r�seau"
