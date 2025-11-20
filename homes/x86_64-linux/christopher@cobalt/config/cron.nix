{
  pkgs,
  config,
  ...
}: let
  bin = ''
    #!/usr/bin/env bash

    ORG="hausgold"
    OUTPUT_FILE="/home/christopher/.gh/$ORG-repos"
    TOKEN=$(cat ${config.age.secrets.repoUpdatePAT.path})

    API_URL="https://api.github.com/orgs/$ORG/repos"

    mkdir -p "$(dirname $OUTPUT_FILE)"
    echo -n "" > $OUTPUT_FILE

    fetch_repositories() {
        local page=$1
        if [ -z "$TOKEN" ]; then
            curl -s "$API_URL?page=$page&per_page=100"
        else
            curl -s -H "Authorization: token $TOKEN" "$API_URL?page=$page&per_page=100"
        fi
    }

    # Pagination loop
    page=1
    while : ; do
        response=$(fetch_repositories $page)
        repo_names=$(echo "$response" | jq -r '.[] | select(.archived == false) | .name')

        if [ -z "$repo_names" ]; then
            break
        fi

        echo "$repo_names" >> $OUTPUT_FILE
        ((page++))
    done

    echo "Repositories have been listed in $OUTPUT_FILE"
  '';

  update-hausgold-gh = pkgs.writeShellApplication {
    name = "update-hausgold-gh";
    text = bin;
  };
in {
  systemd.user.timers."update-hausgold-github" = {
    Install.WantedBy = ["timers.target"];
    Timer = {
      OnBootSec = "1min";
      OnUnitActiveSec = "2h";
      Unit = "update-hausgold-github.service";
    };
  };

  systemd.user.services."update-hausgold-github" = {
    Service.ExecStart = "${update-hausgold-gh}/bin/update-hausgold-gh";
  };
}
