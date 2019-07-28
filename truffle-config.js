const WalletProvider = require("truffle-wallet-provider");
//console.log(process.env.PRIVATE_KEY);
const privateKey = Buffer.from(process.env.PRIVATE_KEY, 'hex');
const wallet = require('ethereumjs-wallet').fromPrivateKey(privateKey);
//console.log(wallet);
const infuraAPIKey = process.env.INFURA_API_KEY;
const rinkebyProvider = new WalletProvider(wallet, `https://rinkeby.infura.io/v3/${infuraAPIKey}`);
const mainnetProvider = new WalletProvider(wallet, `https://mainnet.infura.io/v3/${infuraAPIKey}`);
//console.log(rinkebyProvider);
require('dotenv').config();


module.exports = {
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  },

  networks: {
    development: {
      host: 'localhost',
      port: 8545,
      network_id: '*',
      gas: 6721975
    },
    mainnet: {
      provider: mainnetProvider,
      network_id: 1,
      gas: 500000, // Gas limit used for deploys
      gasPrice: 10000000000
    },
    rinkeby: {
      provider: rinkebyProvider,
      network_id: 4,
      gas: 6900000, // Gas limit used for deploys
      gasPrice: 80000000000
    }
  }
}
