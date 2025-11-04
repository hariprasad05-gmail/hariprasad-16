# Use a newer Node.js base image compatible with Vite 7.x
FROM node:22-alpine

# Set working directory
WORKDIR /app

# Copy dependency files first for caching
COPY package*.json ./

# Install dependencies cleanly
RUN npm ci

# Copy the rest of the application
COPY . .

# Build the application
RUN npm run build --if-present

# Verify build output
RUN ls -la /app

# Install Nginx for serving static files
RUN apk update && apk add --no-cache nginx

# Remove default Nginx site content
RUN rm -rf /usr/share/nginx/html/*

# Copy built assets to Nginx web root
# Adjust 'dist' if your build folder differs
RUN cp -R /app/dist/* /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
