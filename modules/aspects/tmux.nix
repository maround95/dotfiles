{ inputs, ... }:
{
  flake.modules.homeManager.tmux =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      inherit (lib)
        attrByPath
        attrNames
        concatStringsSep
        escapeRegex
        filterAttrs
        map
        ;

      system = pkgs.stdenv.hostPlatform.system;
      tmuxPackage = pkgs.tmux;
      seshPackage = pkgs.sesh;
      seshExe = "${seshPackage}/bin/sesh";
      tmuxRel = "tmux";
      tmuxDir = "${config.xdg.configHome}/${tmuxRel}";
      tmuxTools = import ./tmux-tools/tools.nix {
        inherit pkgs tmuxDir;
        tmux = tmuxPackage;
        sesh = seshPackage;
      };

      mvimScrollbackExe = lib.getExe (inputs.nvim-maroun.lib.mkMvimScrollback { inherit system; });
      mvimPackagesWithTmuxSupport = attrNames (
        filterAttrs (
          _: drv: attrByPath [ "passthru" "tmux-support" ] false drv
        ) inputs.nvim-maroun.packages.${system}
      );
      mvimPattern = "(${concatStringsSep "|" (map escapeRegex mvimPackagesWithTmuxSupport)})";
      zshSeshPick = ''
        bindkey -M viins -r '^B'
        bindkey -M vicmd -r '^B'

        sesh-pick() {
          exec </dev/tty
          exec <&1
          local sel
          sel="$(${tmuxTools}/bin/tmux-sesh-pick)"
          zle reset-prompt >/dev/null 2>&1 || true
          [[ -n "$sel" ]] && sesh connect "$sel"
        }
        zle -N sesh-pick

        bindkey -M viins '^Bs' sesh-pick
        bindkey -M vicmd '^Bs' sesh-pick
      '';
    in
    {
      home.packages = [
        tmuxPackage
        seshPackage
      ];

      programs.zsh.initContent = lib.mkAfter ''
        ${zshSeshPick}
      '';

      xdg.configFile."${tmuxRel}/tmux.conf".text = # tmux
        ''
          set -g default-terminal 'xterm-256color'

          set -g prefix C-b
          set -g base-index 1

          # No escape delay
          set -s escape-time 0
          set -g focus-events on

          set -g set-titles on
          set -g set-titles-string "#S:#I #W — #{pane_current_command}"

          set -g status-position top
          set -g status-style 'bg=default,fg=colour250'

          set-hook -g client-session-changed 'run-shell "tmux refresh-client -S"'
          set-hook -g session-window-changed 'run-shell "tmux refresh-client -S"'

          set -g window-status-format ""
          set -g window-status-current-format ""

          set -g status-left '#[fg=colour250]#S #[fg=colour244]#{s|^#{HOME}|~|:pane_current_path}'
          set -g status-left-length 25
          set -g status-right '#(${tmuxTools}/bin/tmux-status-right #{client_width} #S)'

          # Disable mouse
          set -g mouse on

          # Bigger scrollback buffer
          set-option -g history-limit 50000

          # Set navigation commands as tmux options
          set -gq @nav_left  '${tmuxTools}/bin/tmux-nav pane left'
          set -gq @nav_right '${tmuxTools}/bin/tmux-nav pane right'
          set -gq @nav_up    'tmux select-pane -U -Z'
          set -gq @nav_down  'tmux select-pane -D -Z'

          # new window/pane starts in the same working directory as the current pane
          bind '"' split-window -c "#{pane_current_path}"
          bind % split-window -h -c "#{pane_current_path}"
          bind c new-window -c "#{pane_current_path}"

          bind Up    split-window -v -b -c "#{pane_current_path}"
          bind Down  split-window -v -c "#{pane_current_path}"
          bind Left  split-window -h -b -c "#{pane_current_path}"
          bind Right split-window -h -c "#{pane_current_path}"

          bind -T copy-mode-vi C-e \
            run-shell "sh -c 'EDITOR=${mvimScrollbackExe} ${tmuxTools}/bin/tmux-edit-scrollback main #{pane_id} #{copy_cursor_y} #{copy_cursor_x} #{scroll_position} #{pane_height}; tmux send-keys -t #{pane_id} -X cancel'"

          # tmux handles OSC 52 clipboard sync.
          set -s set-clipboard on

          # Fallback command used by copy-pipe/copy-pipe-and-cancel when no explicit command is given.
          set -s copy-command '${tmuxTools}/bin/tmux-clipboard'

          # v as space alias, y as enter alias + copy into system clipboard
          bind -T copy-mode-vi v send -X begin-selection
          bind -T copy-mode-vi y send -X copy-pipe-and-cancel
          bind -T copy-mode-vi Enter send -X copy-pipe-and-cancel

          bind h run-shell '${tmuxTools}/bin/tmux-nav window left'
          bind l run-shell '${tmuxTools}/bin/tmux-nav window right'

          # Copy Mode
          unbind -T copy-mode-vi MouseDragEnd1Pane # don't exit copy mode when dragging with mouse

          # Is mvim running inside the current pane?
          is_mvim="${tmuxTools}/bin/tmux-is-pane-running '#{pane_tty}' '${mvimPattern}'"

          bind -T root -n 'M-h' if-shell "$is_mvim" 'send-keys M-h' "run-shell '#{@nav_left}'"
          bind -T root -n 'M-j' if-shell "$is_mvim" 'send-keys M-j' "run-shell '#{@nav_down}'"
          bind -T root -n 'M-k' if-shell "$is_mvim" 'send-keys M-k' "run-shell '#{@nav_up}'"
          bind -T root -n 'M-l' if-shell "$is_mvim" 'send-keys M-l' "run-shell '#{@nav_right}'"

          # Toggle floating session
          bind f run-shell ' \
            if [ "$(tmux show-options -qv @is_floating)" = "1" ]; then \
              tmux detach-client; \
            else \
              tmux display-popup -E -w 80% -h 80% \
                "${tmuxTools}/bin/tmux-float #{pane_current_path} #S #{client_tty}"; \
            fi \
          '

          # Move pane to new window in other session
          bind e run-shell ' \
            pane=$(tmux display-message -p "#{pane_id}"); \
            if [ "$(tmux show-options -qv @is_floating)" = "1" ]; then \
              outer=$(tmux show-options -qv @outer_name); \
              if [ -n "$outer" ]; then \
                tmux break-pane -d -s "$pane" -t "$outer:"; \
              fi \
            else \
              float=$(tmux show-options -qv @float_name); \
              if [ -n "$float" ]; then \
                tmux break-pane -d -s "$pane" -t "$float:"; \
              else \
                echo "No floating session. Open with C-b f first." >&2; \
              fi \
            fi \
          '

          # Move pane to existing window (with picker)
          bind E run-shell ' \
            pane=$(tmux display-message -p "#{pane_id}"); \
            if [ "$(tmux show-options -qv @is_floating)" = "1" ]; then \
              outer=$(tmux show-options -qv @outer_name); \
              if [ -n "$outer" ]; then \
                tmux choose-tree -Zs -f "#{==:#{session_name},$outer}" "move-pane -s $pane -t \"%%\""; \
              fi \
            else \
              float=$(tmux show-options -qv @float_name); \
              if [ -n "$float" ]; then \
                tmux choose-tree -Zs -f "#{==:#{session_name},$float}" "move-pane -s $pane -t \"%%\""; \
              fi \
            fi \
          '

          bind s run-shell ' \
            if [ "$(tmux show-options -qv @is_floating)" = "1" ]; then \
              oc=$(tmux show-options -qv @outer_client); \
              tmux detach-client; \
              tmux display-popup -c "$oc" -E -w 80% -h 70% "\
                sel=\$(${tmuxTools}/bin/tmux-sesh-pick || true); \
                [ -n \"\$sel\" ] && ${seshExe} connect \"\$sel\" || true"; \
            else \
              tmux display-popup -E -w 80% -h 70% "\
                sel=\$(${tmuxTools}/bin/tmux-sesh-pick || true); \
                [ -n \"\$sel\" ] && ${seshExe} connect \"\$sel\" || true"; \
            fi \
          '

          bind -N "last-window " W last-window
          bind -N "last-session " L run-shell ' \
            if [ "$(tmux show-options -qv @is_floating)" = "1" ]; then \
              outer="$(tmux show-options -qv @outer_name)"; \
              tmux detach-client; \
              ${tmuxTools}/bin/tmux-attach-to-last-session "$outer" || true; \
            else \
              ${tmuxTools}/bin/tmux-attach-to-last-session "#S" || true; \
            fi \
          '
        '';
    };
}
