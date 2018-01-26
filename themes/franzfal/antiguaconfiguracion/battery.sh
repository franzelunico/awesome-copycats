#!/bin/bash
healthy='#859900'
low='#b58900'
discharge='#dc322f'
# Sin Bateria S/B
capacity='S/B'
capacityColour=$discharge

function status_battery(){
    capacity=`cat /sys/class/power_supply/BAT0/capacity`
    status=`cat /sys/class/power_supply/BAT0/status`
    if (( $capacity <= 25 ));
    then
            capacityColour=$low
    else
            capacityColour=$healthy
                fi
    # Cargador desconectado
    if [[ "$status" = "Discharging" ]]
    then
            statusColour=$discharge
            status="▼"
    else
        # Cargador conectado
        if [[ "$status" = "Charging" ]]; then
            statusColour=$healthy
            status="▲"
        fi
    fi
    if (( $capacity >= 90 ))
    then
        status="Desconecte"
    fi
    echo "| <span color=\"$capacityColour\">$capacity%</span> <span color=\"$statusColour\">$status</span> |"
}

#function_body
if [ -f /sys/class/power_supply/BAT0/capacity ];
then
    status_battery
else
    echo "| <span color=\"$capacityColour\">$capacity</span> |"
fi
