// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:reservation/widgets/pick_country_code.dart';



// final phoneCodeProvider = StateProvider.autoDispose<String>((ref)=> "964");
// final flagImojiProvider = StateProvider.autoDispose<String>((ref)=> "🇮🇶");


// class CountryCodeButton extends StatelessWidget {
//   const CountryCodeButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, ref, _) {
//         final phonecode = ref.watch(phoneCodeProvider);
//         final flagImoji = ref.watch(flagImojiProvider);

//         return TextButton(
//         onPressed: ()=> pickCountryCode(context: context, onSelect: (code){
//           ref.read(phoneCodeProvider.notifier)
//           .update((state) => code.phoneCode);
//           ref.read(flagImojiProvider.notifier)
//           .update((state) => code.flagEmoji);
//         }),
//         child: Text("$flagImoji + $phonecode"));
//       }
//     );
//   }
// }