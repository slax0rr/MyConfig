-- Compatibility shim for nvim-treesitter (master branch) on Neovim 0.12.
--
-- 0.12 dropped the `all = false` option of vim.treesitter.query.add_predicate/
-- add_directive, so handlers now always get `match` as table<id, TSNode[]>.
-- nvim-treesitter master still writes `local node = match[id]` and treats it as
-- a single TSNode, which blows up with e.g.
--
--   treesitter.lua: attempt to call method 'range' (a nil value)
--
-- when opening a markdown file (#set-lang-from-info-string!) or an HCL heredoc
-- (#downcase!).
--
-- Rather than reimplement the plugin's handlers, we temporarily intercept the
-- registration functions and re-register every handler wrapped so it sees the
-- old single-node match table.

local query = require("vim.treesitter.query")

local M = {}

local function first_nodes(match)
  local single = {}
  for id, nodes in pairs(match) do
    single[id] = type(nodes) == "table" and nodes[1] or nodes
  end
  return single
end

local function wrap(handler)
  return function(match, ...)
    return handler(first_nodes(match), ...)
  end
end

function M.setup()
  local add_predicate = query.add_predicate
  local add_directive = query.add_directive

  query.add_predicate = function(name, handler)
    return add_predicate(name, wrap(handler), { force = true })
  end
  query.add_directive = function(name, handler)
    return add_directive(name, wrap(handler), { force = true })
  end

  package.loaded["nvim-treesitter.query_predicates"] = nil
  local ok, err = pcall(require, "nvim-treesitter.query_predicates")

  query.add_predicate = add_predicate
  query.add_directive = add_directive

  if not ok then
    vim.notify("ts_compat: " .. tostring(err), vim.log.levels.WARN)
  end
end

return M
