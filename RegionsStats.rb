require 'java'
require 'net/http'

import java.util.Collection;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.ClusterStatus;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.HConstants;
import org.apache.hadoop.hbase.ServerName;
import org.apache.hadoop.hbase.client.HBaseAdmin;
import org.apache.hadoop.hbase.util.Bytes;

log_level = org.apache.log4j.Level::ERROR

org.apache.log4j.Logger.getLogger("org.apache.zookeeper").setLevel(log_level)
org.apache.log4j.Logger.getLogger("org.apache.hadoop.hbase").setLevel(log_level)

config = HBaseConfiguration.create
config.set 'fs.default.name', config.get(HConstants::HBASE_DIR)

admin = nil
while true
begin
    admin = HBaseAdmin.new config
break
rescue MasterNotRunningException => e
    print 'Waiting for master to start...\n'
    sleep 1
end
end
result = Hash.new
clusterStatus = admin.getClusterStatus
servers = clusterStatus.getServers
print "*******************************************************************\n"
print "Hostname | regions count | regions size\n"
servers.each {|server|
        size=0
        count =0
        serverLoad = clusterStatus.getLoad(server).getRegionsLoad().entrySet()
        serverLoad.each{ |entry|
                result[entry.getValue.getNameAsString]=entry.getValue.getMemStoreSizeMB 
                size = size + entry.getValue.getStorefileSizeMB
                count = count + 1
                print server.getHostname + " " + entry.getValue.getNameAsString + "\n" 
        }
	print server.getHostname + " | " + count.to_s + " | " + size.to_s + "\n"
}
print "*******************************************************************\n"
result = result.sort{|a,b| a[1] <=> b[1]}
result.each { |k,v|
        print v.to_s+ " | " + k +"\n"
}

