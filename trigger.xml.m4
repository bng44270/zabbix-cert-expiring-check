        <trigger>
            ifelse(len(SITEPORT),0,`<expression>{ZBXHOST:certexpirecheck.sh[&quot;SITECN&quot;].last()}&lt;CERTEXPIREAGE</expression>',` <expression>{ZBXHOST:certexpirecheck.sh[&quot;SITECN&quot;,&quot;SITEPORT&quot;].last()&lt;CERTEXPIREAGE</expression>')
            <recovery_mode>0</recovery_mode>
            <recovery_expression/>
            <name>SITECN SSL Certificate</name>
            <correlation_mode>0</correlation_mode>
            <correlation_tag/>
            <url/>
            <status>0</status>
            <priority>4</priority>
            <description/>
            <type>0</type>
            <manual_close>0</manual_close>
            <dependencies/>
            <tags/>
        </trigger>
