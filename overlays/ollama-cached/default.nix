{ channels, ... }: _: prev: {
  ollama-cached = channels.unstable-small.ollama-cuda; # TODO: Do I need this?
}
