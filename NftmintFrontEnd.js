import React from 'react';
import { Form, Input, Button } from 'antd';
import Web3 from 'web3';

const MintNFTForm = () => {
  const [contractAddress, setContractAddress] = useState('');
  const [nftId, setNftId] = useState('');

  const handleSubmit = async () => {
    // Create a connection to the Ethereum network using the Infura API key
    const web3 = new Web3(new Web3.providers.HttpProvider(
      `https://mainnet.infura.io/v3/${/* your Infura project ID */}`
    ));

    // Get the contract instance using the contract address
    const contract = new web3.eth.Contract(/* contract ABI */, contractAddress);

    // Call the minting function on the contract, providing the necessary arguments
    await contract.methods.mint(nftId).send({
      from: /* address of the account minting the NFT */,
    });
  };

  return (
    <Form onFinish={handleSubmit}>
      <Form.Item
        label="Contract address"
        name="contractAddress"
        rules={[{ required: true, message: 'Please enter the contract address!' }]}
      >
        <Input value={contractAddress} onChange={(e) => setContractAddress(e.target.value)} />
      </Form.Item>

      <Form.Item
        label="NFT ID"
        name="nftId"
        rules={[{ required: true, message: 'Please enter the NFT ID!' }]}
      >
        <Input value={nftId} onChange={(e) => setNftId(e.target.value)} />
      </Form.Item>

      <Form.Item>
        <Button type="primary" htmlType="submit">
          Mint NFT
        </Button>
      </Form.Item>
    </Form>
  );
};
