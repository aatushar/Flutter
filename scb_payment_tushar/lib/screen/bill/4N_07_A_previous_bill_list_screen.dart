import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:scb_payment_tushar/screen/bill/4N_03_shop_wise_demand_charge.dart';
import 'package:scb_payment_tushar/screen/bill/4N_04_paybale_bill_list.dart';
import 'package:scb_payment_tushar/screen/complaintScreen/4N_08_my_complaints.dart';
import 'package:scb_payment_tushar/screen/home.dart';
import '../../config/palette.dart';

class PreviousBillListScreen extends StatefulWidget {
  @override
  _PreviousBillListScreenState createState() => _PreviousBillListScreenState();
}

class _PreviousBillListScreenState extends State<PreviousBillListScreen> {
  int _page = 3; // Default index for the current screen
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey =
  GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Palette.backgroundColor,
        appBar: AppBar(
          backgroundColor: Palette.primaryBG,
          elevation: 1,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Acc No: 21010459',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            indicatorColor: Palette.primaryBG60,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade300,
            labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            tabs: [
              Tab(text: 'Due Bills'),
              Tab(text: 'Acc Details'),
              Tab(text: 'Usages'),
              Tab(text: 'Paid Bills'),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Previous Bill List',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Palette.primaryBG10,
                    child: Icon(
                      Icons.download,
                      color: Palette.primaryBG,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  BillCard(
                    billNo: '102421010459',
                    consumption: '758.00KWH',
                    month: 'October',
                    amount: '৳8,436.00',
                    date: '6 Nov 2024',
                  ),
                  SizedBox(height: 12),
                  BillCard(
                    billNo: '092421010459',
                    consumption: '849.00KWH',
                    month: 'September',
                    amount: '৳9,832.00',
                    date: '28 Sep 2024',
                  ),
                  SizedBox(height: 12),
                  BillCard(
                    billNo: '082421010459',
                    consumption: '1,038.00KWH',
                    month: 'August',
                    amount: '৳12,732.00',
                    date: '28 Aug 2024',
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: _page,
              height: 60.0,
              items: <Widget>[
                Icon(Icons.home, size: 30, color: Colors.white),
                Icon(Icons.notifications_on, size: 30, color: Colors.white),
                Image.asset(
                  'assets/images/icons/new/pay_icon.png',
                  height: 45.0,
                  width: 45.0,
                  fit: BoxFit.cover,
                ),
                Icon(Icons.history, size: 30, color: Colors.white),
                Icon(Icons.thumb_down, size: 30, color: Colors.white),
              ],
              color: Palette.primaryBG,
              buttonBackgroundColor: Palette.primaryBG,
              backgroundColor: Palette.backgroundColor,
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 200),
              onTap: (index) {
                setState(() {
                  _page = index;
                  if (_page == 0) {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ShopWiseDemandCharge()));

                  } else if (_page == 1) {
                    // Navigate to notifications
                  } else if (_page == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PayableBillList()),
                    );
                  } else if (_page == 3) {
                    // Stay on this page
                  } else if (_page == 4) {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> MyComplaintsPage()));
                  }
                });
              },
              letIndexChange: (index) => true,
            ),
          ],
        ),
      ),
    );
  }
}

class BillCard extends StatelessWidget {
  final String billNo;
  final String consumption;
  final String month;
  final String amount;
  final String date;

  const BillCard({
    Key? key,
    required this.billNo,
    required this.consumption,
    required this.month,
    required this.amount,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Palette.Shadow10,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bill No : $billNo',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Palette.textClrDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Consumption: $consumption',
            style: TextStyle(
              fontSize: 14,
              color: Palette.textClrGray,
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Billing Month',
                style: TextStyle(
                  fontSize: 14,
                  color: Palette.textClrGray,
                ),
              ),
              Text(
                amount,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Palette.textClrDark,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            month,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Palette.textClrDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            date,
            style: TextStyle(
              fontSize: 14,
              color: Palette.textClrGray,
            ),
          ),
        ],
      ),
    );
  }
}
