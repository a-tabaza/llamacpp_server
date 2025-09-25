# Llama.cpp Server Binaries for Use in Docker Images
This isn't for you, it's to save my time, if it helps, I'm glad, if it doesn't, fork and adapt it.

This is how I use it:

```dockerfile
COPY --from=ghcr.io/a-tabaza/llamacpp_server:main /app/lib/ /app
COPY --from=ghcr.io/a-tabaza/llamacpp_server:main /app/full/llama-server /app
```
