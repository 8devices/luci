--[[

Luci configuration model for statistics - general collectd configuration
(c) 2008 Freifunk Leipzig / Jo-Philipp Wich <xm@leipzig.freifunk.net>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0 

$Id$

]]--

require("ffluci.sys")


m = Map("collectd", "Collector Daemon",
[[Collectd ist ein kleiner und flexibler Dienst zum Sammeln und Abfragen von Daten
aus verschieden Quellen. Zur weiteren Verarbeitung werden die Daten in RRD Datenbanken
gespeichert oder per Multicast Relaying �ber das Netzwerk versendet.]])

-- general config section
s = m:section( NamedSection, "general", "collectd", "Allgemeine Einstellungen" )

-- general.basedir (BaseDir)
basedir = s:option( Value, "BaseDir", "Basisverzeichnis" )
basedir.default = "/var/run/collectd"

-- general.include (Include)
include = s:option( Value, "Include", "Verzeichnis f�r Unterkonfigurationen" )
include.default = "/etc/collectd/conf.d/*.conf"

-- general.pidfile (PIDFile)
pidfile = s:option( Value, "PIDFile", "PID-Datei f�r den Collector Dienst" )
pidfile.default = "/var/run/collectd.pid"

-- general.plugindir (PluginDir)
plugindir = s:option( Value, "PluginDir", "Verzeichnis f�r die Collector-Plugins" )
plugindir.default = "/usr/lib/collectd/"

-- general.typesdb (TypesDB)
typesdb = s:option( Value, "TypesDB", "Datenbank mit den Datenset-Beschreibungen" )
typesdb.default = "/etc/collectd/types.db"

-- general.interval (Interval)
interval = s:option( Value, "Interval", "Abfrageintervall f�r die Datenerfassung in Sekunden" )
interval.default  = 60
interval.isnumber = true

-- general.readthreads (ReadThreads)
readthreads = s:option( Value, "ReadThreads", "Anzahl paralleler Prozesse f�r die Datenabfrage" )
readthreads.default  = 5
readthreads.isnumber = true

-- general.hostname (Hostname)
hostname = s:option( Value, "Hostname", "Hostname zur Identifikation des Collector Dienstes (leer lassen um den Namen automatisch zu bestimmen)" )
hostname.default  = ffluci.sys.hostname()
hostname.optional = true

-- general.fqdnlookup (FQDNLookup)
fqdnlookup = s:option( Flag, "FQDNLookup", "Versuchen den vollen Hostnamen dieser Installation herauszufinden" )
fqdnlookup.enabled  = "true"
fqdnlookup.disabled = "false"
fqdnlookup.default  = "false"
fqdnlookup.optional = true
fqdnlookup:depends( "Hostname", "" )


return m
