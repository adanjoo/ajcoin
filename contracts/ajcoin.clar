;; title: ajcoin
;; version: 1.0.0
;; summary: AJCoin - A SIP-010 compliant fungible token
;; description: AJCoin is a fungible token following the SIP-010 standard on the Stacks blockchain

;; traits
;; Note: SIP-010 trait implementation commented out for local development
;; Uncomment the following line when deploying to testnet/mainnet:
;; (impl-trait 'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE.sip-010-trait-ft-standard.sip-010-trait)

;; token definitions
(define-fungible-token ajcoin)

;; constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))
(define-constant err-insufficient-balance (err u102))
(define-constant err-invalid-amount (err u103))

;; Token configuration
(define-constant token-name "AJCoin")
(define-constant token-symbol "AJC")
(define-constant token-uri u"https://ajcoin.io/metadata.json")
(define-constant token-decimals u6)
(define-constant total-supply u1000000000000) ;; 1 million tokens with 6 decimals

;; data vars
(define-data-var token-uri-var (string-utf8 256) u"https://ajcoin.io/metadata.json")

;; data maps
;; No additional maps needed (using built-in ft tracking)

;; private functions
;; Helper function to check if sender is contract owner
(define-private (is-owner)
  (is-eq tx-sender contract-owner)
)

;; public functions

;; Initialize the token with total supply to contract owner
(define-public (initialize)
  (begin
    (asserts! (is-owner) err-owner-only)
    (try! (ft-mint? ajcoin total-supply contract-owner))
    (ok true)
  )
)

;; Transfer tokens from sender to recipient
(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
  (begin
    (asserts! (is-eq tx-sender sender) err-not-token-owner)
    (asserts! (> amount u0) err-invalid-amount)
    (try! (ft-transfer? ajcoin amount sender recipient))
    (match memo to-print (print to-print) 0x)
    (ok true)
  )
)

;; Mint new tokens (only contract owner)
(define-public (mint (amount uint) (recipient principal))
  (begin
    (asserts! (is-owner) err-owner-only)
    (asserts! (> amount u0) err-invalid-amount)
    (try! (ft-mint? ajcoin amount recipient))
    (ok true)
  )
)

;; Burn tokens from sender
(define-public (burn (amount uint) (sender principal))
  (begin
    (asserts! (is-eq tx-sender sender) err-not-token-owner)
    (asserts! (> amount u0) err-invalid-amount)
    (try! (ft-burn? ajcoin amount sender))
    (ok true)
  )
)

;; Update token URI (only contract owner)
(define-public (set-token-uri (new-uri (string-utf8 256)))
  (begin
    (asserts! (is-owner) err-owner-only)
    (var-set token-uri-var new-uri)
    (ok true)
  )
)

;; read only functions

;; Get token name
(define-read-only (get-name)
  (ok token-name)
)

;; Get token symbol
(define-read-only (get-symbol)
  (ok token-symbol)
)

;; Get token decimals
(define-read-only (get-decimals)
  (ok token-decimals)
)

;; Get balance of an account
(define-read-only (get-balance (account principal))
  (ok (ft-get-balance ajcoin account))
)

;; Get total supply
(define-read-only (get-total-supply)
  (ok (ft-get-supply ajcoin))
)

;; Get token URI
(define-read-only (get-token-uri)
  (ok (some (var-get token-uri-var)))
)

;; Get contract owner
(define-read-only (get-owner)
  (ok contract-owner)
)

