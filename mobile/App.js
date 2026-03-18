import React, { useState } from 'react';
import { Text, View, TextInput, Button, StyleSheet, Alert } from 'react-native';

export default function App() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [logged, setLogged] = useState(false);

  function handleLogin() {
    if (!email || email.indexOf('@') === -1) {
      Alert.alert('Lỗi', 'Vui lòng nhập email hợp lệ');
      return;
    }
    if (!password || password.length < 4) {
      Alert.alert('Lỗi', 'Mật khẩu ít nhất 4 ký tự');
      return;
    }
    // Simulate login
    setLogged(true);
  }

  function handleLogout() {
    setEmail('');
    setPassword('');
    setLogged(false);
  }

  if (logged) {
    return (
      <View style={styles.container}>
        <Text style={styles.title}>Chào mừng, {email}!</Text>
        <Text style={styles.subtitle}>Bạn đã đăng nhập vào mobile app (mẫu)</Text>
        <View style={{marginTop:20}}>
          <Button title="Đăng xuất" onPress={handleLogout} />
        </View>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <Text style={styles.title}>TimViecLam (Mobile)</Text>
      <TextInput
        style={styles.input}
        placeholder="you@example.com"
        autoCapitalize="none"
        keyboardType="email-address"
        value={email}
        onChangeText={setEmail}
      />
      <TextInput
        style={styles.input}
        placeholder="Mật khẩu"
        secureTextEntry
        value={password}
        onChangeText={setPassword}
      />
      <View style={{marginTop:10}}>
        <Button title="Đăng nhập" onPress={handleLogin} />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {flex:1, padding:20, justifyContent:'center'},
  title: {fontSize:22, fontWeight:'700', marginBottom:12},
  subtitle: {fontSize:14, color:'#444'},
  input: {height:44, borderColor:'#ccc', borderWidth:1, borderRadius:8, paddingHorizontal:10, marginTop:12}
});
