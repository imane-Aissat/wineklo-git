import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';

class privacySettings extends StatefulWidget {
  const privacySettings({super.key});

  @override
  State<privacySettings> createState() => _privacySettingsState();
}

class _privacySettingsState extends State<privacySettings> {
  bool _isFavoritesHidden = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        
        centerTitle: true,
        title: Padding(padding: EdgeInsets.all(screenWidth*0.1),
        child: Text(
          'Privacy Settings',
          style: blackSubHeadlineStyle.copyWith(
            fontSize: screenWidth * 0.05,
          ),
        )
        ),
        backgroundColor: whiteColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Visibility Settings',
              style: blackHeadlineStyle.copyWith(fontSize: screenWidth * 0.05),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.red),
              title: Text(
                'Make Favorites Invisible',
                style: blackBodyTextStyle.copyWith(fontSize: screenWidth * 0.045),
              ),
              trailing: Switch(
                value: _isFavoritesHidden,
                onChanged: (value) {
                  setState(() {
                    _isFavoritesHidden = value;
                  });
                },
              ),
              subtitle: Text(
                _isFavoritesHidden
                    ? "Your favorites are hidden from others."
                    : "Your favorites are visible to others.",
                style: grayBodyTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
