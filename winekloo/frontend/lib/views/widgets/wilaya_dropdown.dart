import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';

class WilayaDropdown extends StatelessWidget {
  final String? selectedWilayaId;
  final ValueChanged<String?> onChanged;

  const WilayaDropdown({
    Key? key,
    required this.selectedWilayaId,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of Wilaya names
    final List<String> wilayas = [
      "Adrar", "Chlef", "Laghouat", "Oum el-Bouaghi", "Batna", "Béjaïa", "Biskra",
      "Béchar", "Blida", "Bouïra", "Tamanghasset", "Tébessa", "Tlemcen", "Tiaret", 
      "Tizi Ouzou", "Algiers", "Djelfa", "Jijel", "Sétif", "Saïda", "Skikda", "Sidi Bel Abbès",
      "Annaba", "Guelma", "Constantine", "Médéa", "Mostaganem", "M'sila", "Mascara", "Ouargla", 
      "Oran", "El Bayadh", "Illizi", "Bordj Bou Arréridj", "Boumerdès", "El Taref", "Tindouf", 
      "Tissemsilt", "El Oued", "Khenchela", "Souk Ahras", "Tipaza", "Mila", "Aïn Defla", 
      "Naâma", "Aïn Témouchent", "Ghardaïa", "Relizane", "El M'ghair", "El Menia", "Ouled Djellal",
      "Bordj Baji Mokhtar", "Béni Abbès", "Timimoun", "Touggourt", "Djanet", "In Salah", "In Guezzam"
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Wilaya',
            style: TextStyle(
              fontFamily: 'Sen',
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: blackColor,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedWilayaId,
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: lightGrayColor,
              hintText: 'Select your Wilaya',
              hintStyle: const TextStyle(
                fontFamily: 'Sen',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: darkGrayColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
            items: wilayas.map<DropdownMenuItem<String>>((wilaya) {
              return DropdownMenuItem<String>(
                value: wilaya,
                child: Text(
                  wilaya,
                  style: const TextStyle(
                    fontFamily: 'Sen',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: blackColor,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
