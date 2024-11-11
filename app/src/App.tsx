import React, { useState } from 'react';
import { Button, Typography, Container } from '@mui/material';

const API = process.env.REACT_APP_API || "";

function App() {
  const [message, setMessage] = useState('');

  const handleClick = async () => {
    try {
      const response = await fetch(`${API}/`);
      const data = await response.json();
      setMessage(data.message);
    } catch (error) {
      console.error('Error fetching the message:', error);
    }
  };

  return (
    <Container>
      <Typography variant="h1" component="h2" gutterBottom>
        Winball
      </Typography>
      <Button variant="contained" color="primary" onClick={handleClick}>
        Call /api/hc
      </Button>
      {message && (
        <Typography variant="h5" component="p" gutterBottom>
          Message: {message}
        </Typography>
      )}
    </Container>
  );
}

export default App;
