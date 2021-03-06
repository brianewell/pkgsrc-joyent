$NetBSD$

Make SunOS portable. Patch by Derek Crudgington.
--- scripts/wsrep_sst_xtrabackup-v2.sh.orig	2015-03-26 08:01:34.000000000 +0000
+++ scripts/wsrep_sst_xtrabackup-v2.sh
@@ -359,7 +359,13 @@ get_stream()
 get_proc()
 {
     set +e
-    nproc=$(grep -c processor /proc/cpuinfo)
+
+    if [[ $(uname -s | grep SunOS) ]]; then
+        nproc=$(kstat -p caps::cpucaps_zone*:value | awk '{ printf "%d", ($2+100-1)/100 }')
+    else
+        nproc=$(grep -c processor /proc/cpuinfo)
+    fi
+
     [[ -z $nproc || $nproc -eq 0 ]] && nproc=1
     set -e
 }
@@ -491,7 +497,11 @@ wait_for_listen()
     local MODULE=$3
     for i in {1..50}
     do
-        ss -p state listening "( sport = :$PORT )" | grep -qE 'socat|nc' && break
+        if [[ $(uname -s | grep SunOS) ]]; then
+            (pfiles $(pgrep 'socat|nc') || true) | grep "AF_INET.* ${PORT}$" >/dev/null && break
+        else
+            ss -p state listening "( sport = :$PORT )" | grep -qE 'socat|nc' && break
+        fi
         sleep 0.2
     done
     echo "ready ${ADDR}/${MODULE}"
