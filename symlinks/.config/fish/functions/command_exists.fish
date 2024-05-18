#!/bin/bash
function command_exists
    command -v "$argv" >/dev/null 2>&1
end
