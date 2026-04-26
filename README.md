# ERC20 Token Smart Contract

## 📌 Description

This project is a custom implementation of an ERC20 token written in Solidity. It includes core token functionality such as transfers, minting, burning, and an allowance system (`approve` and `transferFrom`).

The contract is fully tested using Foundry and designed to help understand how real-world tokens work.

---

## 🚀 Features

* ✅ Token name, symbol, and decimals
* ✅ Balance tracking using mapping
* ✅ Transfer tokens between users
* ✅ Mint new tokens (only owner)
* ✅ Burn tokens (user-controlled)
* ✅ Allowance system (approve & transferFrom)
* ✅ Event logging (`Transfer`, `Approval`)
* ✅ Full test coverage using Foundry

---

## 🧠 Smart Contract Overview

### State Variables

* `name` → Token name
* `symbol` → Token symbol
* `decimals` → Token precision (18)
* `totalSupply` → Total tokens in circulation
* `balanceOf` → Stores balances of users
* `allowance` → Stores approved spending limits
* `owner` → Contract deployer

---

### Core Functions

#### 🔹 transfer(address to, uint256 amount)

Transfers tokens from sender to another address.

#### 🔹 approve(address spender, uint256 amount)

Allows another address to spend tokens on your behalf.

#### 🔹 transferFrom(address from, address to, uint256 amount)

Allows a spender to transfer tokens from an approved account.

#### 🔹 mint(address to, uint256 amount)

Creates new tokens and assigns them to an address (only owner).

#### 🔹 burn(uint256 amount)

Destroys tokens from the caller’s balance.

---

## 🧪 Testing

This project uses Foundry for testing.

### Test Coverage Includes:

* ✔ Deployment checks
* ✔ Transfer functionality
* ✔ Revert cases (invalid address, insufficient balance)
* ✔ Minting restrictions (only owner)
* ✔ Burning logic
* ✔ Approve and allowance system
* ✔ transferFrom behavior

### Run Tests

```bash
forge test
```

---

## ⚠️ Known Risks / Learning Notes

* Owner can mint unlimited tokens (centralization risk)
* Approval race condition (standard ERC20 issue)
* Sending tokens to the contract address may lock them permanently

---

## 🏗️ Tech Stack

* Solidity ^0.8.20
* Foundry (Forge)

---

## 👤 Author

Hassan Salad

---

## 📜 License

MIT
