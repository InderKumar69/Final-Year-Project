// // ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class HistoricalPlacesScreen extends StatefulWidget {
//   @override
//   _HistoricalPlacesScreenState createState() => _HistoricalPlacesScreenState();
// }

// class _HistoricalPlacesScreenState extends State<HistoricalPlacesScreen> {
//   final TextEditingController _headingController = TextEditingController();
//   final TextEditingController _explanationController = TextEditingController();

//   void _savePlace() async {
//     final heading = _headingController.text.trim();
//     final explanation = _explanationController.text.trim();

//     if (heading.isNotEmpty && explanation.isNotEmpty) {
//       await FirebaseFirestore.instance
//           .collection('Peshawar_Historical_Places')
//           .doc(heading)
//           .set({
//         'heading': heading,
//         'explanation': explanation,
//       });

//       _headingController.clear();
//       _explanationController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Historical Places'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _headingController,
//                   decoration: InputDecoration(
//                     labelText: 'Heading',
//                   ),
//                 ),
//                 TextField(
//                   controller: _explanationController,
//                   decoration: InputDecoration(
//                     labelText: 'Explanation',
//                   ),
//                   maxLines: 4,
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: _savePlace,
//                   child: Text('Save'),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('Peshawar_Historical_Places')
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 final docs = snapshot.data!.docs;

//                 return ListView.builder(
//                   itemCount: docs.length,
//                   itemBuilder: (context, index) {
//                     final doc = docs[index];
//                     final heading = doc['heading'];
//                     final explanation = doc['explanation'];

//                     return Card(
//                       child: ListTile(
//                         title: Text(heading),
//                         subtitle: Text(explanation),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
