<?php
    $maxchildren = '5';

    // because not work for parse for inline php
    echo "<" . "?xml version=\"1.0\" ?" . ">" . "\n";
?>
<configuration>
    <section name="global_options">
        <value name="pid_file">/var/run/php-fpm.pid</value>
        <value name="error_log">/var/log/php-fpm/error.log</value>
        <value name="log_level">notice</value>
        <value name="emergency_restart_threshold">10</value>
        <value name="emergency_restart_interval">1m</value>
        <value name="process_control_timeout">5s</value>
        <value name="daemonize">yes</value>
    </section>

    <workers>
        <section name="pool">
            <value name="name">default</value>
            <value name="listen_address">127.0.0.1:50000</value>
            <value name="listen_options">
                <value name="backlog">-1</value>
                <value name="owner"></value>
                <value name="group"></value>
                <value name="mode">0666</value>
            </value>
            <value name="user">apache</value>                
            <value name="group">apache</value>        
            <value name="pm">
                <value name="style">static</value>
                <value name="max_children"><?php echo $maxchildren; ?></value>
            </value>
            <value name="request_terminate_timeout">0s</value>
            <value name="request_slowlog_timeout">0s</value>
            <value name="slowlog">/var/log/php-fpm/slow.log</value>
            <value name="rlimit_files">1024</value>
            <value name="rlimit_core">0</value>
            <value name="chroot"></value>
            <value name="chdir"></value>
            <value name="catch_workers_output">yes</value>
            <value name="max_requests">500</value>
            <value name="allowed_clients">127.0.0.1</value>
            <value name="environment">
                <value name="HOSTNAME">$HOSTNAME</value>
                <value name="PATH">/usr/local/bin:/usr/bin:/bin</value>
                <value name="TMP">/tmp</value>
                <value name="TMPDIR">/tmp</value>
                <value name="TEMP">/tmp</value>
                <value name="OSTYPE">$OSTYPE</value>
                <value name="MACHTYPE">$MACHTYPE</value>
                <value name="MALLOC_CHECK_">2</value>
            </value>
        </section>
<?php
    foreach ($userlist as &$user) {
        $userinfo = posix_getpwnam($user);
        $fpmport = (50000 + $userinfo['uid']);
?>

        <section name="pool">
            <value name="name"><?php echo $user; ?></value>
            <value name="listen_address">127.0.0.1:<?php echo $fpmport; ?></value>
            <value name="listen_options">
                <value name="backlog">-1</value>
                <value name="owner"></value>
                <value name="group"></value>
                <value name="mode">0666</value>
            </value>
            <value name="user"><?php echo $user; ?></value>                
            <value name="group"><?php echo $user; ?></value>        
            <value name="pm">
                <value name="style">static</value>
                <value name="max_children"><?php echo $maxchildren; ?></value>
            </value>
            <value name="request_terminate_timeout">0s</value>
            <value name="request_slowlog_timeout">0s</value>
            <value name="slowlog">/var/log/php-fpm/slow.log</value>
            <value name="rlimit_files">1024</value>
            <value name="rlimit_core">0</value>
            <value name="chroot"></value>
            <value name="chdir"></value>
            <value name="catch_workers_output">yes</value>
            <value name="max_requests">500</value>
            <value name="allowed_clients">127.0.0.1</value>
            <value name="environment">
                <value name="HOSTNAME">$HOSTNAME</value>
                <value name="PATH">/usr/local/bin:/usr/bin:/bin</value>
                <value name="TMP">/tmp</value>
                <value name="TMPDIR">/tmp</value>
                <value name="TEMP">/tmp</value>
                <value name="OSTYPE">$OSTYPE</value>
                <value name="MACHTYPE">$MACHTYPE</value>
                <value name="MALLOC_CHECK_">2</value>
            </value>
        </section>
<?php
    }
?>
    </workers>
</configuration>
