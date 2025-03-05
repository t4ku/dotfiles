FROM ruby:3.2-slim

# Install required dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    netcat-traditional \
    && rm -rf /var/lib/apt/lists/*

# Install solargraph
RUN gem install solargraph

# Create app directory
WORKDIR /usr/src/app

# Set default command
CMD ["solargraph", "socket", "--host=0.0.0.0", "--port=7658"]
