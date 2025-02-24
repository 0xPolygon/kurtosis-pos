require('babel-register')
require('babel-polyfill')

const chai = require('chai')
const chaiAsPromised = require('chai-as-promised')
chai.use(chaiAsPromised).should()

var HDWalletProvider = require('@truffle/hdwallet-provider')

const MNEMONIC = { privateKeys: [process.env.PRIVATE_KEY] }
const L1_RPC_URL = process.env.L1_RPC_URL
const L2_RPC_URL = process.env.L2_RPC_URL

module.exports = {
  networks: {
    l1: {
      provider: () =>
        new HDWalletProvider({
          ...MNEMONIC,
          providerOrUrl: L1_RPC_URL
        }),
      network_id: '*', // match any network
      skipDryRun: true,
      gas: 0
    },
    l2: {
      provider: () =>
        new HDWalletProvider({
          ...MNEMONIC,
          providerOrUrl: L2_RPC_URL
        }),
      network_id: '*', // match any network
      gasPrice: '90000000000'
    }
  },
  compilers: {
    solc: {
      version: '0.5.17',
      parser: 'solcjs',
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        },
        evmVersion: 'constantinople'
      }
    }
  },
  mocha: {
    bail: false,
    reporter: 'eth-gas-reporter',
    reporterOptions: {
      currency: 'USD',
      gasPrice: 21,
      outputFile: '/dev/null',
      showTimeSpent: true
    }
  },
  plugins: ['solidity-coverage', 'truffle-contract-size'],
  verify: {
    preamble: 'Matic network contracts'
  }
}
