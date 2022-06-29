// class HourlyData extends StatelessWidget {
//   final List data;
//   const HourlyData({Key? key, required this.data}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 220,
//         width: 160,
//         margin: const EdgeInsets.all(5.0),
//         padding: const EdgeInsets.all(10.0),
//         decoration: BoxDecoration(
//           // color: ColorService.darkBlue,
//           borderRadius: BorderRadius.circular(12),
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               ColorService.gradientHourlyBody,
//               ColorService.darkBlue,
//             ],
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: ColorService.shadowTop,
//               offset: const Offset(-4.0, -4.0),
//               blurRadius: 15,
//               spreadRadius: 1.0,
//             ),
//             BoxShadow(
//               color: ColorService.shadowBottom,
//               offset: const Offset(4.0, 4.0),
//               blurRadius: 15,
//               spreadRadius: 1.0,
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(data[2],
//                     style: const TextStyle(
//                         color: Colors.white70,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center),
//                 Text('${data[3]} ℃',
//                     style: const TextStyle(
//                         color: Colors.white70,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold)),
//               ],
//             ),
//             Flexible(
//                 child: Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: Container(
//                     height: 86,
//                     padding: const EdgeInsets.all(2.0),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           ColorService.gradientHourlyBody,
//                           ColorService.darkBlue,
//                         ],
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: ColorService.shadowTop,
//                           offset: const Offset(-4.0, -4.0),
//                           blurRadius: 15,
//                           spreadRadius: 1.0,
//                         ),
//                         BoxShadow(
//                           color: ColorService.shadowBottom,
//                           offset: const Offset(4.0, 4.0),
//                           blurRadius: 15,
//                           spreadRadius: 1.0,
//                         ),
//                       ],
//                     ),
//                     child: Image.asset(
//                       'assets/weather_icons/${data[1].split('/').toList()[5]}/${data[1].split('/').toList()[6]}',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 )),
//             Text(data[0].substring(10),
//                 style: const TextStyle(
//                     color: Colors.white70,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold)),
//           ],
//         ));
//   }
// }
