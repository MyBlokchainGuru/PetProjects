import React, { useState } from "react";

const SmartContractForm = () => {
  const [abi, setAbi] = useState("");
  const [contractAddress, setContractAddress] = useState("");
  const [method, setMethod] = useState("");
  const [params, setParams] = useState("");
  const [result, setResult] = useState("");

  const callSmartContract = async () => {
    const contract = new web3.eth.Contract(JSON.parse(abi), contractAddress);
    const data = await contract.methods[method](params).call();
    setResult(data);
  };

  return (
    <div>
      <h1>Smart Contract Form</h1>
      <form>
        <label>ABI</label>
        <textarea
          value={abi}
          onChange={(e) => setAbi(e.target.value)}
          rows="10"
          cols="50"
        />
        <label>Contract Address</label>
        <input
          type="text"
          value={contractAddress}
          onChange={(e) => setContractAddress(e.target.value)}
        />
        <label>Method</label>
        <input
          type="text"
          value={method}
          onChange={(e) => setMethod(e.target.value)}
        />
        <label>Params</label>
        <input
          type="text"
          value={params}
          onChange={(e) => setParams(e.target.value)}
        />
        <button onClick={callSmartContract}>Call Contract</button>
      </form>
      <h2>Result</h2> 
      <p>{result}</p>
    </div>
  );
};

export default SmartContractForm;
