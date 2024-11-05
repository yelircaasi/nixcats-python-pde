# viminal2

This is my second attempt at creating a Neovim configuration intended for
NixOS. The [first](https://github.com/youwen5/viminal) was configured using
[Nixvim](https://github.com/nix-community/nixvim). This mostly worked, except
you often had to escape into raw Lua strings to get precise customization.

Enter [nixCats](https://github.com/BirdeeHub/nixCats-nvim). It provides the
tools needed to mix Nix and Lua in your configurations. For advanced users,
configuring Neovim with Nix expressions doesn't really make sense, since the
whole point of Neovim is to be extremely hackable ("hyperextensible") and it
provides ergonomic Lua bindings for that purpose.

This setup provides not just a usable but a "great" Neovim configuration for
NixOS. That is, it has features that make it _better_ on _all distros_, not
just on NixOS. Why? Instead of using ad-hoc package managers written for Neovim
like `lazy.nvim`, `Mason`, etc, all external dependencies are fetched and built
by Nix. Mason and lazy are good for what they are meant for, but Nix can make
strong guarantees that practically no other package management tool can,
period. Namely, it can ensure the presence of runtime dependencies (like `rg`,
`fd`, LSPs, formatters, etc), and guarantee builds are successful. If your
editor works today, it'll work tomorrow. It won't break from system upgrades or
files randomly getting broken. Nix is purpose built to handle pretty much
everything that a text editor's plugins shouldn't, and it's a perfect match.

## Try it

You can test drive the configuration (even if you aren't on NixOS) if you have
the Nix package manager available (with flakes).

```bash
nix run 'github:youwen5/viminal2'
```

## Design

As this is my second configuration from scratch (if you count Nixvim as "from
scratch"), I wanted to do it right (so I could stop wasting my time configuring
my editor).

For completion, I use [blink.cmp](https://github.com/Saghen/blink.cmp). This
plugin is much, much faster than `nvim-cmp` thanks to optimized `SIMD`
instructions (and Rust), has a better fuzzy search, and comes with more out of
the box.

`lz.n` is used to load plugins after they have been downloaded by Nix. `lz.n`
is a lazy loading plugin by the authors of `Rocks.nvim`, a plugin manager based
on Luarocks. As they are designed to be decoupled, `Rocks.nvim` can simply be
replaced by Nix. Most plugins are lazy loaded, but generally performance is
good enough that it is not even strictly necessary.

The keybinds have gotten a lot more idiosyncratic. Instead of focusing on
mnemonic keys that can be easily committed to memory, highly efficient ones
were chosen instead.

## License

Feel free to copy any code from here or use it as an example. It's [public
domain](./LICENSE).

## Roadmap

- [ ] Watch on basic setup / LSP
      - [ ] [My NeoVim Setup](https://www.youtube.com/watch?v=ZqPpBfiX9ws&pp=ygUWcHl0aG9uIHNldHVwIGluIG5lb3ZpbQ%3D%3D)
      - [ ] [Understanding Neovim Playlist](https://www.youtube.com/playlist?list=PLx2ksyallYzW4WNYHD9xOFrPRYGlntAft)
      - [ ] [Understanding Neovim #7 - Language Server Protocol](https://www.youtube.com/watch?v=HL7b63Hrc8U)
      - [ ] [Make Neovim BETTER than VSCode - LSP tutorial](https://www.youtube.com/watch?v=lpQMeFph1RE)
      - [ ] [Neovim for Newbs. FREE NEOVIM COURSE](https://www.youtube.com/playlist?list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn)
      - [ ] [How to setup Neovim from Scratch - Complete Guide (Including TMUX, Lazy and LSP)](https://www.youtube.com/watch?v=ZjMzBd1Dqz8)
      - [ ] [Awesome Neovim Setup From Scratch - Full Guide](https://www.youtube.com/watch?v=JWReY93Vl6g)
      - [ ] [How I Setup LSP In Neovim For An Amazing Dev Experience - Full Guide](https://www.youtube.com/watch?v=NL8D8EkphUw)
      - [ ] [Basic Neovim LSP Setup (with Treesitter and Completion)](https://www.youtube.com/watch?v=Ku-m7eEbWas)
      - [ ] [Neovim - LSP Setup Tutorial (Built in LSP 100% Lua)](https://www.youtube.com/watch?v=6F3ONwrCxMg)
      - [ ] [quick.nvim | A fast, modern and reliable Neovim configuration](https://www.youtube.com/watch?v=OhbgZbORFd4)
      - [ ] [Full Neovim Setup from Scratch in 2024](https://www.youtube.com/watch?v=KYDG3AHgYEs&t=58s&pp=ygUNbmVvdmltIHB5dGhvbg%3D%3D)
      - [ ] [My Entire Neovim Setup From Scratch After 8 Years](https://www.youtube.com/watch?v=x__SZUuLOxw&pp=ygUlVGhlIHVsdGltYXRlIE5lb3ZpbSBzZXR1cCBmb3IgUHl0aG9uIQ%3D%3D)
      - [ ] [How I Setup Neovim To Make It AMAZING in 2024: The Ultimate Guide](https://www.youtube.com/watch?v=6pAG3BHurdM&pp=ygUlVGhlIHVsdGltYXRlIE5lb3ZpbSBzZXR1cCBmb3IgUHl0aG9uIQ%3D%3D)
      - [ ] [Ultimate Neovim Config | 2024 | Launch.nvim](https://www.youtube.com/watch?v=KGJV0n70Mxs&pp=ygUlVGhlIHVsdGltYXRlIE5lb3ZpbSBzZXR1cCBmb3IgUHl0aG9uIQ%3D%3D)
      - [ ] [Neovim Configuration](https://www.youtube.com/playlist?list=PLsz00TDipIffxsNXSkskknolKShdbcALR)
      - [ ] [Neovim from Scratch (chris@machine)](https://www.youtube.com/playlist?list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ)
- [ ] Watch on debugging
      - [ ] [Debugging Code in Neovim (Rust, Go, Python etc)](https://www.youtube.com/watch?v=djpMB9LPkBc&pp=ygUQbmVvdmltIGRlYnVnZ2luZw%3D%3D)
      - [ ] [Debugging In Neovim (ft BashBunni)](https://www.youtube.com/watch?v=0moS8UHupGc&pp=ygUQbmVvdmltIGRlYnVnZ2luZw%3D%3D)
      - [ ] [How to ACTUALLY switch from VS Code to Neovim](https://www.youtube.com/watch?v=BQa16JNRkpY&pp=ygUQbmVvdmltIGRlYnVnZ2luZw%3D%3D)
      - [ ] [[Neovim] Debugging with NVIM-DAP](https://www.youtube.com/watch?v=lEMZnrC-ST4)
      - [ ] [simple neovim debugging setup (in 10 minutes)](https://www.youtube.com/watch?v=lyNfnI-B640)
      - [ ] [Neovim + nvim-dap-python + Debugpy + PDM](https://www.youtube.com/watch?v=wwxL98-UiI0&pp=ygUQbmVvdmltIGRlYnVnZ2luZw%3D%3D)
      - [ ] [Neovim Plugin: nvim-dap](https://www.youtube.com/watch?v=ga3Cas7vNCk&pp=ygUQbmVvdmltIGRlYnVnZ2luZw%3D%3D)
- [ ] Watch on Python-specific
      - [ ] [The perfect Neovim setup for Python](https://www.youtube.com/watch?v=4BnVeOUeZxc&t=590s&pp=ygUQbmVvdmltIGRlYnVnZ2luZw%3D%3D)
      - [ ] [Neovim Starter Kit for Python](https://www.youtube.com/results?search_query=neovim+python)
      - [ ] [Run Python code on Neovim with Compiler.nvim](https://www.youtube.com/watch?v=4WJOY2xgYgs&pp=ygUNbmVvdmltIHB5dGhvbg%3D%3D)
      - [ ] [The ultimate Neovim setup for Python!](https://www.youtube.com/watch?v=4yqALty1tcQ&pp=ygUlVGhlIHVsdGltYXRlIE5lb3ZpbSBzZXR1cCBmb3IgUHl0aG9uIQ%3D%3D)
      - [ ] [Neovim Lazy Lua IDE - my simple but powerful setup for 2024](https://www.youtube.com/watch?v=VljhZ0e9zGE&t=1235s)
- [ ] Watch on completion
      - [ ] [I replaced my nvim-cmp with blink.cmp](https://www.youtube.com/watch?v=6JpLA1WfP2s&pp=ygUQbmVvdmltIGJsaW5rLmNtcA%3D%3D)
- [ ] Watch

## Plugins Shortlist

- dashboard.nvim
- --> [m1chaelwilliams](https://github.com/m1chaelwilliams/my-nvim-config/tree/main/lua/plugins)
- 