"""
Provide CLI

This module provides the CLI to enter the program.
"""

import sys
import typing as t
from pathlib import Path

import typer

app = typer.Typer()


def main() -> None:
    if len(sys.argv) == 1:
        snapshot()
    else:
        app()


@app.command()
def open(device: t.Annotated[t.Optional[Path], typer.Argument()] = None) -> None:
    typer.echo(f"Opening {device}...")


@app.command()
def close(device: t.Annotated[t.Optional[Path], typer.Argument()] = None) -> None:
    typer.echo(f"Closing {device}...")


@app.command()
def snapshot(device: t.Annotated[t.Optional[Path], typer.Argument()] = None) -> None:
    typer.echo("Making a snapshot of the root subvolume...")


if __name__ == "__main__":
    main()
