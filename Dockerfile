# Stage 1: Build the Angular App
FROM node:20.11.1-slim as builder

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install && mkdir /angular-ui && mv ./node_modules ./angular-ui

WORKDIR /angular-ui

# Copy source code
COPY . .

# Build the Angular app
RUN npm run build

# Stage 2: Serve the Application with Express.js
FROM node:20.11.1-slim

# Set working directory
WORKDIR /angular-ui

# Copy built Angular app from builder stage
COPY --from=builder /angular-ui/dist/angular17 /angular-ui/dist/angular17
COPY ./server.js /angular-ui

# Install Express.js
RUN npm install express

# Expose port 4200 for frontend
EXPOSE 4200

# Start the server
CMD ["node", "server.js"]
