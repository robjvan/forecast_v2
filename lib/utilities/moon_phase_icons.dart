import 'package:flutter/material.dart';

@immutable
class MoonParser {
  static Widget newMoon() {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: 30,
          height: 30,
          color: Colors.transparent,
        ),
      ),
    );
  }

  static Widget fullMoon() {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: 30,
          height: 30,
          color: Colors.white70,
        ),
      ),
    );
  }

  static Widget waxingGibbous() {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 30,
                height: 30,
                color: Colors.transparent,
              ),
            ),
            Positioned(
              left: 7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 30,
                  height: 30,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget waningGibbous() {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 30,
                height: 30,
                color: Colors.transparent,
              ),
            ),
            Positioned(
              right: 7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 30,
                  height: 30,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget firstQuarter() {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 30,
                height: 30,
                color: Colors.transparent,
              ),
            ),
            Positioned(
              left: 15,
              child: Container(
                width: 30,
                height: 30,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget thirdQuarter() {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 30,
                height: 30,
                color: Colors.transparent,
              ),
            ),
            Positioned(
              right: 15,
              child: Container(
                width: 30,
                height: 30,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget waxingCrescent() {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 30,
                height: 30,
                color: Colors.white70,
              ),
            ),
            Positioned(
              height: 30,
              width: 30,
              right: 7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 30,
                  height: 30,
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget waningCrescent() {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 30,
                height: 30,
                color: Colors.white70,
              ),
            ),
            Positioned(
              height: 30,
              width: 30,
              left: 7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 30,
                  height: 30,
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget getIcon(final String moonPhase) {
    switch (moonPhase) {
      case 'New Moon':
        return newMoon();
      case 'Waxing Crescent':
        return waxingCrescent();
      case 'First Quarter':
        return firstQuarter();
      case 'Waxing Gibbous':
        return waxingGibbous();
      case 'Full Moon':
        return fullMoon();
      case 'Waning Gibbous':
        return waningGibbous();
      case 'Last Quarter':
        return thirdQuarter();
      case 'Waning Crescent':
        return waningCrescent();
      default:
        return Container();
    }
  }
}
