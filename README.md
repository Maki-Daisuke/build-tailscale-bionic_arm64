# Build Tailscale for Ubuntu 18.04 (Bionic) on arm64

## Usage

```bash
# You may need to run this command to install Qemu for Docker
docker run --privileged --rm tonistiigi/binfmt --install all

# Build Tailscale and Docker image containing the results
docker buildx build --platform linux/arm64 -t tailscale_builder .

# Create a temporary container from the image
docker create --name temp_container tailscale_builder

# Extract the results from the container to the current directory
docker cp temp_container:/app/tailscale/tailscale .
docker cp temp_container:/app/tailscale/tailscaled .

# Cleanup the image and the container if you want
docker rm temp_container
docker rmi tailscale_builder
```

## LICENSE

MIT License

## Author

Daisuke (yet another) Maki
