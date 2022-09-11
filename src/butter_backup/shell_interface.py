from __future__ import annotations

import os
import subprocess
from pathlib import Path
from typing import List, Optional, Union

from loguru import logger

_CMD_LIST = Union[List[str], List[Path], List[Union[str, Path]]]
_LISTS_OF_CMD_LIST = Union[
    List[List[str]], List[List[Path]], List[List[Union[str, Path]]]
]
StrPathList = List[Union[str, Path]]


class ShellInterfaceError(ValueError):
    pass


def run_cmd(
    *,
    cmd: _CMD_LIST,
    env: Optional[dict[str, str]] = None,
    capture_output: bool = False,
) -> subprocess.CompletedProcess[bytes]:
    if env is None:
        env = dict(os.environ)
    logger.debug(f"Shell-Befehl ist `{cmd}`.")
    result = subprocess.run(cmd, capture_output=capture_output, check=True, env=env)
    return result


def pipe_pass_cmd_to_real_cmd(
    pass_cmd: str, command: StrPathList
) -> subprocess.CompletedProcess[bytes]:
    logger.debug(f"Shell-Befehl ist `{command}`.")
    pwd_proc = subprocess.run(pass_cmd, stdout=subprocess.PIPE, shell=True, check=True)
    completed_process = subprocess.run(command, input=pwd_proc.stdout, check=True)
    return completed_process


def get_user() -> str:
    """Get user who started ButterBackup

    This function will determine the user who is running ButterBackup. It does
    so by reading out the USER environment variable. In cases where this
    variable does not exist, e.g. in Docker containers, it assumes that the
    user is root.

    Returns:
    --------
    str
        user name of user who started ButterBackup
    """
    return os.environ.get("USER", default="root")
