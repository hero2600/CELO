yq -i -y '.scrape_configs[] |= (.job_name as $name | .static_configs += if $name == "prometheus" then [] else ([{targets:["'$1'" + (if $name == "node" then ":9100" elif $name == "cosmos" then ":26660" else ":9300" end)], labels:(if $name == "validator" then {address: "'$2'"} elif $name == "wallet" then {address: "'$3'"} else {} end)}]) end)' $HOME/cosmos_node_monitoring/prometheus/prometheus.yml