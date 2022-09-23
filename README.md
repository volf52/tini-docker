# Minimal Image for tini

https://github.com/krallin/tini

## Usage

Or in a docker image (multistage build)

```dockerfile
# ... other build steps

FROM volf52/tini:1.1 as tini-src

# Use the binary in other stages
FROM base as prod

COPY --from=tini-src /bin/tini /bin/tini

ENTRYPOINT ["/bin/tini", "--", "/app"]
```
