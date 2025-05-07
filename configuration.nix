# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cartera = {
    isNormalUser = true;
    description = "Carter Aitken";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
  ];
};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ((vim_configurable.override {  }).customize{
      name = "vim";
    # Install plugins for example for syntax highlighting of nix files
    vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
      start = [ 
        vim-nix
        vim-lastplace
        vim-cpp-enhanced-highlight
        nerdtree
        vim-airline
        vim-airline-themes
        vimtex
        vim-lsp
        haskell-vim 
      ];
      opt = [];
    };
    vimrcConfig.customRC = ''

    "#plugins
     "##vim-cpp-enhanced-highlight: Set C syntax options
     let g:cpp_class_scope_highlight = 1
     let g:cpp_member_variable_highlight = 1
     let g:cpp_class_decl_highlight = 1
     "##nerdtree
     let g:NERDTreeWinPos = "right"
     let g:NERDTreeMinimalUI = 1
     "##airline
     set laststatus=2
      let g:airline_powerline_fonts = 1  " Enable powerline fonts if installed
      let g:airline_theme = 'tomorrow'
      let g:airline_section_b = '%{getcwd()}'  " Show current working directory
      let g:airline_section_c = '%t'  " Show filename
      "let g:airline#extensions#tabline#enabled = 1  " Enable the tabline
      "let g:airline#extensions#tabline#formatter = 'unique_tail'  " Show just filename in tabs
      let g:airline#extensions#branch#enabled = 1  " Show git branch if availableA
      " Display buffers in the tabline when only one tab is open
      "let g:airline#extensions#tabline#show_buffers = 1

      " Show line/column number
      let g:airline_section_z = '%l:%c'

      " Shorten mode display
      let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'S',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ }

      " Refresh airline when entering buffer
      autocmd BufEnter * :AirlineRefresh
      " DONT TELL ME ABOUD FKING TRAILING WHITESPACE ASSHOLE
      let g:airline#extensions#whitespace#enabled = 0

"##vim-devicons
set encoding=UTF-8

let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1

     " utility
     set nocompatible
     set foldmethod=manual
     let g:netrw_banner=0
     let g:netrw_browse_split=4
     let g:netrw_altv=1
     let g:netrw_liststyle=3
     let g:netrw_winsize = 30
     filetype on
     filetype plugin on
     filetype indent on
     set shiftwidth=2
     set tabstop=2
     set expandtab
     set incsearch
     set path+=**
     set wildmenu
     set wildmode=list:longest
     set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx,*.o,*.d,*.out
     set noshowcmd
     set laststatus=2

     " appearance
     set rnu
     set colorcolumn=80
     colorscheme slate
     syntax on

     " lsp

     " hide warning popups
     let g:lsp_diagnostics_enabled = 0
    let g:lsp_document_code_action_signs_enabled = 0 "  :h vim-lsp :798
    " guild of the governd
if executable('clangd')
  augroup lsp_clangd
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ 'inititalization_options': {'codeActionProvider': v:false},
        \ })
    autocmd FileType c setlocal omnifunc=lsp#complete
  augroup end
endif

if executable('haskell-language-server-wrapper')
  augroup lsp_haskell
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'haskell-language-server',
        \ 'cmd': {server_info->['haskell-language-server-wrapper', '--lsp']},
        \ 'whitelist': ['haskell', 'lhaskell'],
        \ 'initialization_options': {},
        \ 'workspace_config': {
        \   'haskell': {
        \     'formattingProvider': 'ormolu',
        \     'checkProject': v:true,
        \   }
        \ }
        \ })
    autocmd FileType haskell setlocal omnifunc=lsp#complete
  augroup end
endif

         function! s:on_lsp_buffer_enabled() abort
         setlocal omnifunc=lsp#complete
         nmap <buffer> gd <plug>(lsp-definition)
         nmap <buffer> gr <plug>(lsp-references)
         nmap <buffer> K <plug>(lsp-hover)
         endfunction

         augroup lsp_install
         au!
         " call s:on_lsp_buffer_enabled only for languages that has the server registered.
         autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
         augroup END



         " auto mappings
         augroup tex_mappings
         autocmd FileType tex nnoremap <buffer> <leader>m :term ++shell ++close pdflatex *.tex<CR>
         autocmd FileType tex set scrolloff=20
         augroup END

         augroup cc_mappings
         autocmd FileType cpp map <buffer> <leader>e :term ++shell make<CR>
         autocmd FileType cpp map <buffer> <leader>m :term ++shell ++close make<CR>
         autocmd FileType h map <buffer> <leader>m :term ++shell ++close make<CR>
         autocmd FileType cpp noremap <buffer> <leader>r :vertical term<CR>make run<CR>
         augroup END

         augroup c_mappings
         autocmd FileType c set syntax=cpp
         autocmd FileType c map <buffer> <leader>e :term ++shell make<CR>
         autocmd FileType c map <buffer> <leader>q :!echo test<CR>
         autocmd FileType c map <buffer> <leader>m :term ++shell ++close make<CR>
         autocmd FileType h map <buffer> <leader>m :term ++shell ++close make<CR>
         autocmd FileType c noremap <buffer> <leader>r :vertical term<CR>make run<CR>
         autocmd FileType c noremap <buffer> <leader>S :term ++shell ++close make assemble<CR>
         autocmd FileType c noremap <buffer> <leader>s :tabnew main.s<CR>
         "autocmd FileType c noremap <buffer> <leader>r :! make run<CR>
         augroup END

augroup hs_mappings
  autocmd FileType haskell map <buffer> <leader>e :term ++shell make<CR>
  autocmd FileType haskell noremap <buffer> <leader>r :vertical term<CR>make run<CR>
  autocmd FileType haskell map <buffer> <leader>m :term ++shell ++close make<CR>
augroup END

         " global mappings
         let mapleader = " "
         noremap <leader>v :! sudo vim /etc/nixos/configuration.nix<CR>
         map <leader>o o\[\]<C-c>hi
         map <leader>O O\[\]<C-c>hi
         map <leader>b o\bbox<CR>\begin{(++)}<CR><++><CR>\end{(++)}<CR>\ebox<CR><Esc>kkkV=kkk/(++)<CR>cab
         map <leader>B n.?<++><CR>ca<
         map <leader>z :term ++close ++shell zathura --fork *.pdf<CR>
         map <leader>g /<++><CR>
         map <leader>J gJhhdf[
           noremap <leader>h <C-w>h
           noremap <leader>l <C-w>l
           imap <C-e> \(\)<C-o>h
        " plugin-based mappings
         noremap <leader>a :LspCodeAction<CR>
        noremap <leader>f :NERDTreeFocus<CR>


    '';
  }
  )

  vim # text editor
  wget # ? idk default
  pkgs.neofetch # nice looking intro
  btop # pc monitor
  git # version control & remote
  tree

  texliveFull # full latex packages. $PATH changed @ .bashrc to nixos-shell -p texliveFull; echo $PATH
  zathura # pdf viewer for tex

  clang # c compiler
  valgrind # c mem checker
  gdb # c debugger
  gcc14 # looking for g++-14

  ncurses # c window library
  raylib # c raylib library
  clang-tools # clangd, c-vim-lsp w/ vim-lsp (on github, at ~/.vim/pack/vendor/start/)
  universal-ctags # ctags for vim

  ## haskell
  ghc
  cabal-install
  xorg.libX11
  xorg.libXrandr
  xorg.libXi
  xorg.libXcursor
  xorg.libXinerama
  libGL
  haskell-language-server

  ## software
  pkgs.brave # browser
  discord	# msgs
  spotify # music
];

environment.variables = {
  EDITOR = "vim";
  LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [
    pkgs.raylib
  ]}:\${LD_LIBRARY_PATH}";
  }; 

  environment.pathsToLink = [ "/include" ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  }; 

  fonts.fonts = with pkgs; [
    jetbrains-mono 
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
