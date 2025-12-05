# AJCoin (AJC)

A SIP-010 compliant fungible token smart contract built on the Stacks blockchain using Clarity.

## Overview

AJCoin is a fungible token that implements the SIP-010 standard, providing a secure and standardized way to create and manage tokens on Stacks. This implementation includes essential token functionality such as transfers, minting, burning, and balance queries.

## Features

- **SIP-010 Compliance**: Fully compatible with the Stacks fungible token standard
- **Minting**: Contract owner can mint new tokens to any address
- **Burning**: Token holders can burn their own tokens
- **Transfer**: Transfer tokens between addresses with optional memo
- **Balance Queries**: Check balance of any address
- **Metadata**: Configurable token URI for metadata
- **Security**: Owner-only functions for administrative operations

## Token Details

- **Name**: AJCoin
- **Symbol**: AJC
- **Decimals**: 6
- **Total Supply**: 1,000,000 AJC (1,000,000,000,000 base units)

## Smart Contract Functions

### Public Functions

#### `initialize`
Mints the total supply to the contract owner. Can only be called once by the contract owner.

```clarity
(initialize)
```

#### `transfer`
Transfer tokens from the sender to a recipient.

```clarity
(transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
```

**Parameters:**
- `amount`: Number of tokens to transfer (in base units)
- `sender`: Address sending the tokens (must be tx-sender)
- `recipient`: Address receiving the tokens
- `memo`: Optional memo attached to the transfer

#### `mint`
Mint new tokens to a recipient address. Only callable by contract owner.

```clarity
(mint (amount uint) (recipient principal))
```

**Parameters:**
- `amount`: Number of tokens to mint
- `recipient`: Address to receive the minted tokens

#### `burn`
Burn tokens from the sender's balance.

```clarity
(burn (amount uint) (sender principal))
```

**Parameters:**
- `amount`: Number of tokens to burn
- `sender`: Address burning the tokens (must be tx-sender)

#### `set-token-uri`
Update the token URI. Only callable by contract owner.

```clarity
(set-token-uri (new-uri (string-utf8 256)))
```

### Read-Only Functions

#### `get-name`
Returns the token name.

```clarity
(get-name)
```

#### `get-symbol`
Returns the token symbol.

```clarity
(get-symbol)
```

#### `get-decimals`
Returns the number of decimals.

```clarity
(get-decimals)
```

#### `get-balance`
Returns the balance of an account.

```clarity
(get-balance (account principal))
```

#### `get-total-supply`
Returns the total supply of tokens in circulation.

```clarity
(get-total-supply)
```

#### `get-token-uri`
Returns the token URI for metadata.

```clarity
(get-token-uri)
```

#### `get-owner`
Returns the contract owner address.

```clarity
(get-owner)
```

## Error Codes

- `u100`: `err-owner-only` - Action requires contract owner privileges
- `u101`: `err-not-token-owner` - Transaction sender is not the token owner
- `u102`: `err-insufficient-balance` - Insufficient token balance
- `u103`: `err-invalid-amount` - Invalid amount (must be greater than 0)

## Development Setup

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet) - Clarity development environment
- Node.js (v18 or higher) - For running tests

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/ajcoin.git
cd ajcoin
```

2. Install dependencies:
```bash
npm install
```

### Checking Contract Syntax

Verify contract syntax with Clarinet:

```bash
clarinet check
```

### Running Tests

Run the test suite:

```bash
npm test
```

### Interactive Console

Launch an interactive Clarity REPL:

```bash
clarinet console
```

### Local Development Network

Start a local devnet for testing:

```bash
clarinet integrate
```

## Deployment

### Testnet Deployment

1. Configure your testnet settings in `settings/Testnet.toml`
2. Deploy using Clarinet:

```bash
clarinet deployments generate --testnet
clarinet deployments apply --testnet
```

### Mainnet Deployment

1. Configure your mainnet settings in `settings/Mainnet.toml`
2. Deploy using Clarinet:

```bash
clarinet deployments generate --mainnet
clarinet deployments apply --mainnet
```

## Project Structure

```
ajcoin/
├── contracts/
│   └── ajcoin.clar          # Main token contract
├── tests/
│   └── ajcoin.test.ts       # TypeScript unit tests
├── settings/
│   ├── Devnet.toml          # Devnet configuration
│   ├── Testnet.toml         # Testnet configuration
│   └── Mainnet.toml         # Mainnet configuration
├── Clarinet.toml            # Clarinet project configuration
├── package.json             # Node.js dependencies
└── README.md                # This file
```

## Security Considerations

- The contract owner has privileged access to mint tokens and update the token URI
- Token transfers require the sender to be the transaction sender (tx-sender)
- All amounts must be greater than zero
- The SIP-010 standard ensures compatibility with wallets and exchanges

## License

MIT License - see [LICENSE](LICENSE) file for details

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Resources

- [Stacks Documentation](https://docs.stacks.co/)
- [Clarity Language Reference](https://docs.stacks.co/clarity/)
- [SIP-010 Fungible Token Standard](https://github.com/stacksgov/sips/blob/main/sips/sip-010/sip-010-fungible-token-standard.md)
- [Clarinet Documentation](https://docs.hiro.so/clarinet/)

## Contact

For questions or support, please open an issue in the GitHub repository.
