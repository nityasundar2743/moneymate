import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Savings Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Color(0xFFF0F0F0),
        fontFamily: 'SF Pro Display',
      ),
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      body: SafeArea(
        child: _selectedIndex == 0 
            ? SavedGoalsPage(waveController: _waveController) 
            : HistoryPage(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Color(0xFF00BCD4),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.savings_outlined),
              activeIcon: Icon(Icons.savings),
              label: 'Goals',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined),
              activeIcon: Icon(Icons.history),
              label: 'History',
            ),
          ],
        ),
      ),
    );
  }
}

class SavedGoalsPage extends StatefulWidget {
  final AnimationController waveController;

  SavedGoalsPage({required this.waveController});

  @override
  _SavedGoalsPageState createState() => _SavedGoalsPageState();
}

class _SavedGoalsPageState extends State<SavedGoalsPage>
    with TickerProviderStateMixin {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  bool _showQuickEdit = true;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Status bar area
          Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '22:11',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '0.08',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    Text(
                      'KB/S',
                      style: TextStyle(fontSize: 8, color: Colors.grey),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.home, size: 14, color: Colors.grey),
                    SizedBox(width: 2),
                    Icon(Icons.camera_alt_outlined, size: 14, color: Colors.grey),
                    SizedBox(width: 2),
                    Icon(Icons.wifi, size: 14, color: Colors.grey),
                    SizedBox(width: 2),
                    Icon(Icons.signal_cellular_4_bar, size: 14, color: Colors.grey),
                    SizedBox(width: 2),
                    Text('91%', style: TextStyle(fontSize: 12, color: Colors.black)),
                    SizedBox(width: 2),
                    Icon(Icons.battery_full, size: 16, color: Colors.green),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                // Header
                Text(
                  'Backup and Share',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Collab with others',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF666666),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 30),

                // Savings Summary
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Saved £60979/£202957',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Color(0xFF00BCD4), width: 2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        'Upgrade!',
                        style: TextStyle(
                          color: Color(0xFF00BCD4),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                // Furniture Goal Card
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFD8D8D8),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        // Wave animation for furniture card
                        AnimatedBuilder(
                          animation: widget.waveController,
                          builder: (context, child) {
                            return CustomPaint(
                              painter: WavePainter(
                                animationValue: widget.waveController.value,
                                color: Color(0xFFC0C0C0),
                                height: 0.5, // 50% progress
                              ),
                              size: Size(double.infinity, 200),
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Furniture',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.cloud_outlined,
                                        color: Color(0xFF666666),
                                        size: 20,
                                      ),
                                      SizedBox(width: 12),
                                      Icon(
                                        Icons.text_fields,
                                        color: Color(0xFF666666),
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Text(
                                '£500.0 / £1000.0 (50.0%)',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Remaining: £500.0',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF666666),
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Quick Edit',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF666666),
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Color(0xFF666666),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              // Action Icons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildActionIcon(Icons.edit_outlined),
                                  _buildActionIcon(Icons.delete_outline),
                                  _buildActionIcon(Icons.history),
                                  _buildActionIcon(Icons.trending_up_outlined),
                                  _buildActionIcon(Icons.calendar_today_outlined),
                                  _buildActionIcon(Icons.share_outlined),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // House Saving Goal Card with Wave Animation
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF8FD3B8),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        // Wave animation for house card
                        AnimatedBuilder(
                          animation: widget.waveController,
                          builder: (context, child) {
                            return CustomPaint(
                              painter: WavePainter(
                                animationValue: widget.waveController.value,
                                color: Color(0xFF7BC8A8),
                                height: 0.3, // 30% progress
                              ),
                              size: Size(double.infinity, 400),
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Saving for a house',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.cloud_outlined,
                                        color: Color(0xFF4A4A4A),
                                        size: 20,
                                      ),
                                      SizedBox(width: 12),
                                      Icon(
                                        Icons.text_fields,
                                        color: Color(0xFF4A4A4A),
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Text(
                                '£60000.0 / £200000.0 (30.0%)',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Remaining: £140000.0',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF4A4A4A),
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Quick Edit',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF4A4A4A),
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_up,
                                    color: Color(0xFF4A4A4A),
                                  ),
                                ],
                              ),
                              
                              // Quick Edit Form with Animation
                              AnimatedSize(
                                duration: Duration(milliseconds: 300),
                                child: _showQuickEdit ? Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF7BC8A8),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: TextField(
                                        controller: _amountController,
                                        decoration: InputDecoration(
                                          hintText: 'Amount',
                                          hintStyle: TextStyle(
                                            color: Color(0xFF4A4A4A),
                                            fontSize: 16,
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(16),
                                        ),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF7BC8A8),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: TextField(
                                        controller: _noteController,
                                        decoration: InputDecoration(
                                          hintText: 'Note (Optional)',
                                          hintStyle: TextStyle(
                                            color: Color(0xFF4A4A4A),
                                            fontSize: 16,
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(16),
                                        ),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 50,
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Minus',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xFFE57373),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                elevation: 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        Expanded(
                                          child: Container(
                                            height: 50,
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Add',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xFF4CAF50),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                elevation: 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ) : SizedBox.shrink(),
                              ),
                              
                              SizedBox(height: 20),
                              // Action Icons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildActionIcon(Icons.edit_outlined),
                                  _buildActionIcon(Icons.delete_outline),
                                  _buildActionIcon(Icons.history),
                                  _buildActionIcon(Icons.trending_up_outlined),
                                  _buildActionIcon(Icons.calendar_today_outlined),
                                  _buildActionIcon(Icons.share_outlined),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Icon(
        icon,
        color: Color(0xFF4A4A4A),
        size: 22,
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;
  final Color color;
  final double height;

  WavePainter({
    required this.animationValue,
    required this.color,
    required this.height,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final waveHeight = 20.0;
    final waveLength = size.width / 2;

    // Start from bottom
    final startY = size.height * (1 - height);
    path.moveTo(0, startY);

    // Create wave
    for (double x = 0; x <= size.width; x++) {
      final y = startY + 
          waveHeight * math.sin((x / waveLength * 2 * math.pi) + 
          (animationValue * 2 * math.pi));
      path.lineTo(x, y);
    }

    // Complete the fill
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

class HistoryPage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction('15/06/2022', 'DEPOSIT', 180.0, true),
    Transaction('14/06/2022', 'DEPOSIT', 68.0, true),
    Transaction('13/06/2022', 'WITHDRAWAL', 294.0, false),
    Transaction('12/06/2022', 'WITHDRAWAL', 274.0, false),
    Transaction('11/06/2022', 'DEPOSIT', 163.0, true),
    Transaction('10/06/2022', 'WITHDRAWAL', 253.0, false),
    Transaction('09/06/2022', 'WITHDRAWAL', 201.0, false),
    Transaction('08/06/2022', 'WITHDRAWAL', 155.0, false),
    Transaction('07/06/2022', 'DEPOSIT', 154.0, true),
    Transaction('06/06/2022', 'WITHDRAWAL', 110.0, false),
    Transaction('05/06/2022', 'DEPOSIT', 2.0, true),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Status bar area
        Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '11:00',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Icon(Icons.wifi, size: 14, color: Colors.white),
                  SizedBox(width: 2),
                  Icon(Icons.signal_cellular_4_bar, size: 14, color: Colors.white),
                  SizedBox(width: 2),
                  Text('100%', style: TextStyle(fontSize: 12, color: Colors.white)),
                  SizedBox(width: 2),
                  Icon(Icons.battery_full, size: 16, color: Colors.white),
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Color(0xFF4A4A4A),
          ),
        ),

        Expanded(
          child: Container(
            color: Color(0xFF4A4A4A),
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'History',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'All transactions saved',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFCCCCCC),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                // History Card
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'History',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final transaction = transactions[index];
                              return Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              transaction.date,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              transaction.type,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF666666),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${transaction.isDeposit ? '+' : '-'}£${transaction.amount.toStringAsFixed(1)}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: transaction.isDeposit 
                                                ? Color(0xFF00BCD4) 
                                                : Color(0xFFE57373),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (index < transactions.length - 1)
                                    Container(
                                      height: 1,
                                      color: Color(0xFFF0F0F0),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Transaction {
  final String date;
  final String type;
  final double amount;
  final bool isDeposit;

  Transaction(this.date, this.type, this.amount, this.isDeposit);
}