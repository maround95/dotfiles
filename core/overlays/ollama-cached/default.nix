{ rawChannels, ... }:
final: prev: {
  ollama-cached = rawChannels.unstable-small.ollama-cuda;
}
