import 'package:doctor_v2/Signup/signup.dart';
import 'package:doctor_v2/components/copyButton/copy_button.dart';
import 'package:doctor_v2/context/wallet/wallet_provider.dart';

import 'package:doctor_v2/utils/eth_amount_formatter.dart';
import 'package:flutter/material.dart';

class Balance extends StatelessWidget {
  const Balance({
    Key? key,
    required this.address,
    required this.ethBalance,
    required this.tokenBalance,
  }) : super(key: key);

  final String? address;
  final BigInt? ethBalance;
  final BigInt? tokenBalance;

  @override
  Widget build(BuildContext context) {
    final store = useWallet(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(address ?? ''),
          CopyButton(
            text: const Text('Copy address'),
            value: address,
          ),
          if (address != null)
            //   QrImage(
            //     data: address!,
            //     size: 150.0,
            //   ),
            // Text(
            //   '${EthAmountFormatter(tokenBalance).format()} tokens',
            //   style:
            //       Theme.of(context).textTheme.bodyText2?.apply(fontSizeDelta: 6),
            // ),
            Text(
              '${EthAmountFormatter(ethBalance).format()} eth',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.apply(color: Colors.blueGrey),
            ),
          SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () async {
                await store.resetWallet();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Register(
                              token: address,
                            )));
              },
              child: Text(
                'Back to SignUp',
                style: TextStyle(fontSize: 30),
              ),
            ),
          )
        ],
      ),
    );
  }
}
