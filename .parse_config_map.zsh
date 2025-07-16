home_dir="${HOME:A}"

xdg_config_dir="${${XDG_CONFIG_HOME:-$home_dir/.config}:A}"
xdg_data_dir="${${XDG_DATA_HOME:-$home_dir/.local/share}:A}"

typeset -A config_map
while IFS=$'\n' read -r line; do
    echo "$line" | IFS=':' read src_path target_path
    target_path=${target_path/#~\//$home_dir/}
    target_path=${target_path/#{XDG_CONFIG}\//$xdg_config_dir/}
    target_path=${target_path/#{XDG_DATA}\//$xdg_data_dir/}
    config_map[$src_path]=$target_path
done < "$repo/config_map"
