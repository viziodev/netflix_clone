import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/person.dart';

class CastingCard extends StatelessWidget {
  final Person person;
  const CastingCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              width: 170,
              imageUrl: person.imagePerson(),
              fit: BoxFit.cover,
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10, left: 10)),
          SizedBox(
            width: 130,
            child: Text(person.name,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ),
          const Padding(padding: EdgeInsets.only(left: 10)),
          SizedBox(
            width: 130,
            child: Text(person.characterName,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                )),
          )
        ],
      ),
    );
  }
}
