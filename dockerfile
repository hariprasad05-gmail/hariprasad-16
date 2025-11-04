# Base image
FROM node:22-alpine

# Set working directory
WORKDIR /app

# Copy only package files first (for caching)
COPY template-vanilla/package*.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the application
COPY template-vanilla/ .

# Build the app
RUN npm run build --if-present

# Expose port (if applicable)
EXPOSE 3000

# Start command
CMD ["npm", "start"]
