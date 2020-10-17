import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/data/models/Weather.dart';
import 'package:weather_app/data/weather_repository.dart';

class WeatherSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    var cityController = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
            child: Container(
          child: FlareActor(
            "assets/WorldSpin.flr",
            fit: BoxFit.contain,
            animation: "roll",
          ),
          height: 300,
          width: 300,
        )),
        BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitial)
              return Container(
                padding: EdgeInsets.only(
                  left: 32,
                  right: 32,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Search Weather",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70),
                    ),
                    Text(
                      "Instanly",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w200,
                          color: Colors.white70),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white70,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.white70,
                                style: BorderStyle.solid)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.blue, style: BorderStyle.solid)),
                        hintText: "City Name",
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        onPressed: () {
                          weatherBloc.add(SearchWeather(cityController.text));
                        },
                        color: Colors.lightBlue,
                        child: Text(
                          "Search",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              );
            else if (state is WeatherLoading)
              return Center(child: CircularProgressIndicator());
            else if (state is WeatherLoaded)
              return ShowWeather(state.weather, cityController.text);
            else if (state is NetworkError) {
              return Text(
                "Error",
                style: TextStyle(color: Colors.white),
              );
            }
          },
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class ShowWeather extends StatelessWidget {
  Weather weather;
  final city;

  ShowWeather(this.weather, this.city);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 32, left: 32, top: 10),
        child: Column(
          children: <Widget>[
            Text(
              city,
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              weather.getTemp.round().toString() + "C",
              style: TextStyle(color: Colors.white70, fontSize: 50),
            ),
            Text(
              "Temprature",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      weather.getMinTemp.round().toString() + "C",
                      style: TextStyle(color: Colors.white70, fontSize: 30),
                    ),
                    Text(
                      "Min Temprature",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      weather.getMaxTemp.round().toString() + "C",
                      style: TextStyle(color: Colors.white70, fontSize: 30),
                    ),
                    Text(
                      "Max Temprature",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: FlatButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                onPressed: () {
                  BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
                },
                color: Colors.lightBlue,
                child: Text(
                  "Reset",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            )
          ],
        ));
  }
}