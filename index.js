/* eslint-disable react/prop-types */
import React from 'react';
import {AppRegistry, StyleSheet, Text, View, TouchableOpacity, NativeModules} from 'react-native';

var RNBradgeManager = NativeModules.RNBradgeManager;

class RNHighScores extends React.Component {
  render() {
    var contents = this.props['scores'].map((score) => (
      <Text key={score.name}>
        {score.name}:{score.value}
        {'\n'}
      </Text>
    ));
    return (
      <View style={{flex: 1}}>
        <View style={{height: 60}}>
          <TouchableOpacity style={{marginLeft: 15, marginTop: 15, width: 80}} onPress={()=> RNBradgeManager.backAction()}>
            <Text style={{fontSize: 20,textAlign: 'center', marginLeft: 10}}>Back</Text>
          </TouchableOpacity>
        </View>
        <View style={styles.container}>
          <Text style={styles.highScoresTitle}>2048 High Scores!</Text>
          <Text style={styles.scores}>{contents}</Text>
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
  },
  highScoresTitle: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  scores: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

// Module name
AppRegistry.registerComponent('RNHighScores', () => RNHighScores);