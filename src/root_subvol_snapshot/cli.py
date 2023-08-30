"""
Provide CLI

This module provides the CLI to enter the program.
"""
import typing as t
from pathlib import Path

import typer

app = typer.Typer()


@app.command()
def open(device: t.Annotated[t.Optional[Path], typer.Argument()] = None) -> None:
    typer.echo(f"Opening {device}...")


@app.command()
def close(device: t.Annotated[t.Optional[Path], typer.Argument()] = None) -> None:
    typer.echo(f"Closing {device}...")


if __name__ == "__main__":
    app()
