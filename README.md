# Content Storage Contract

A simple smart contract for storing user content on Ethereum.

## Quick Start

### 1. Install Dependencies
```bash
forge install
```

### 2. Start Local Blockchain
```bash
anvil
```

### 3. Deploy Contract
```bash
source .env && forge script script/ContentStorage.sol:ContentStorageScript --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY --broadcast
```

### 4. Frontend Integration

Use the deployed contract address and connect to `http://localhost:8545` in your frontend.

**Contract ABI**: Located at `out/ContentStorage.sol/ContentStorage.json`

**Example Frontend Connection**:
```javascript
// Using ethers.js
const contract = new ethers.Contract(
  "DEPLOYED_CONTRACT_ADDRESS",
  contractABI,
  provider
);
```