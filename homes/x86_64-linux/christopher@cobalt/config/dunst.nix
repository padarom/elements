# Dunst is used for displaying system notifications.
# It is configured here, so that its styling looks better.
{...}: {
  services.dunst = {
    enable = true;

    settings = {
      global = {
        font = "Roboto 11";
        format = "<b>%s</b>\\n%b";
        width = 300;
        height = 100;
        offset = "7x7";

        frame_color = "#8AADF4";
        frame_width = 2;
        gap_size = 8;
        line_height = 2;

        sort = true;

        # Not really relevant for single-monitor setup, but doesn't hurt either
        monitor = 0;
        follow = "mouse";
      };

      urgency_low = {
        background = "#24273A";
        foreground = "#CAD3F5";
        timeout = 10;
      };

      urgency_normal = {
        background = "#24273A";
        foreground = "#CAD3F5";
        timeout = 10;
      };

      urgency_critical = {
        background = "#24273A";
        foreground = "#CAD3F5";
        frame_color = "#F5A97F";
        timeout = 0;
      };
    };
  };
}
