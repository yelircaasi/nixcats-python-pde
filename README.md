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
