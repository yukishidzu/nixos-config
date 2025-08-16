{ config, pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;
    
    # Красивые темы
    interactiveShellInit = ''
      # Fish git prompt
      set __fish_git_prompt_showdirtystate 'yes'
      set __fish_git_prompt_showstashstate 'yes'
      set __fish_git_prompt_showuntrackedfiles 'yes'
      set __fish_git_prompt_showupstream 'yes'
      set __fish_git_prompt_color_branch yellow
      set __fish_git_prompt_color_upstream_ahead green
      set __fish_git_prompt_color_upstream_behind red
      
      # Цвета для Fish
      set fish_color_normal normal
      set fish_color_command 89b4fa
      set fish_color_param cdd6f4
      set fish_color_redirection f5c2e7
      set fish_color_comment 6c7086
      set fish_color_error f38ba8
      set fish_color_escape eba0ac
      set fish_color_operator f5c2e7
      set fish_color_end f5c2e7
      set fish_color_quote a6e3a1
      set fish_color_autosuggestion 6c7086
      set fish_color_user 89b4fa
      set fish_color_host 89b4fa
      set fish_color_host_remote a6e3a1
      set fish_color_cancel f38ba8
      set fish_color_selection 313244
      set fish_color_search_match 89b4fa
      set fish_color_history_current 89b4fa
      set fish_color_valid_path 89b4fa
      
      # Алиасы
      alias ll='ls -la'
      alias la='ls -A'
      alias l='ls -CF'
      alias ..='cd ..'
      alias ...='cd ../..'
      alias ....='cd ../../..'
      alias .....='cd ../../../..'
      alias grep='grep --color=auto'
      alias fgrep='fgrep --color=auto'
      alias egrep='egrep --color=auto'
      alias diff='diff --color=auto'
      alias ip='ip --color=auto'
      alias ls='ls --color=auto'
      alias dir='dir --color=auto'
      alias vdir='vdir --color=auto'
      alias grep='grep --color=auto'
      alias fgrep='fgrep --color=auto'
      alias egrep='egrep --color=auto'
      alias diff='diff --color=auto'
      alias ip='ip --color=auto'
      
      # Функции
      function mkcd
          mkdir -p $argv
          cd $argv
      end
      
      function backup
          cp $argv $argv.backup
      end
      
      function extract
          if test -f $argv
              switch $argv
                  case "*.tar.gz"
                      tar -xzf $argv
                  case "*.tar.bz2"
                      tar -xjf $argv
                  case "*.tar.xz"
                      tar -xJf $argv
                  case "*.tar"
                      tar -xf $argv
                  case "*.zip"
                      unzip $argv
                  case "*.rar"
                      unrar x $argv
                  case "*.7z"
                      7z x $argv
                  case "*"
                      echo "Неизвестный формат архива"
              end
          else
              echo "Файл не найден"
          end
      end
      
      function weather
          curl wttr.in/$argv
      end
      
      function speedtest
          curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -
      end
      
      # Приветствие
      echo "🐟 Добро пожаловать в Fish shell!"
      echo "📚 Используйте 'help' для справки"
      echo "🎨 Тема: Catppuccin Mocha"
      echo ""
    '';
    
    # Плагины
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "e0e1b9ed9b2b2643c6c2d3d3c3c3c3c3c3c3c3c3c";
          sha256 = "0000000000000000000000000000000000000000000000000000";
        };
      }
      {
        name = "fzf";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "e0e1b9ed9b2b2643c6c2d3d3c3c3c3c3c3c3c3c3c";
          sha256 = "0000000000000000000000000000000000000000000000000000";
        };
      }
    ];
  };
}
