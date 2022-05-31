import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/pages/current_weather_page/controller/current_weather_page_controller.dart';
import 'package:weather/services/color_service.dart';

class CurrentPage extends StatelessWidget {
  const CurrentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CurrentController>(
      init: CurrentController(),
      builder: (_controller) {
        return Scaffold(
          backgroundColor: ColorService.darkBlue,
          body: _controller.noData
              ? Center(
                  child: Lottie.asset(
                      'assets/lottie/no_internet_connection.json',
                      height: 300))
              : SafeArea(
                  child: CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate(
                          [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(_controller.dates.first,
                                          style: const TextStyle(
                                              color: ColorService.lightBlue2,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.white,
                                          ),
                                          Flexible(
                                            child: Text(
                                              ' ${_controller.location.first}, ',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: const TextStyle(
                                                  color: ColorService.lightBlue1,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              _controller.location.last,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: const TextStyle(
                                                  color: ColorService.lightBlue2,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                IconButton(
                                  padding:
                                  const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                                  icon: const Icon(
                                    CupertinoIcons.refresh_circled_solid,
                                    color: ColorService.lightBlue2,
                                    size: 34,
                                  ),
                                  onPressed: () {
                                    _controller.updateData();
                                  },
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            GlassmorphicContainer(
                                width: MediaQuery.of(context).size.width,
                                height: 180,
                                borderRadius: 30,
                                blur: 20,
                                alignment: Alignment.bottomCenter,
                                border: 2,
                                linearGradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      ColorService.gradientTopBody,
                                      ColorService.gradientBottomBody
                                    ],
                                    stops: const [
                                      0.1,
                                      1,
                                    ]),
                                borderGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    ColorService.gradientTopBorder,
                                    ColorService.gradientBottomBorder
                                  ],
                                ),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          'assets/images/weather_sun_cloud_little_rain.png',
                                          height: 200,
                                          width: 200),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(_controller.currentWeather[1],
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 26,
                                                    fontWeight: FontWeight.bold)),
                                            Text('${_controller.currentWeather[2]} ℃',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 36,
                                                    fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            const SizedBox(height: 20),
                            GlassmorphicContainer(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              borderRadius: 30,
                              blur: 20,
                              border: 2,
                              linearGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    ColorService.gradientTopBody,
                                    ColorService.gradientBottomBody
                                  ],
                                  stops: const [
                                    0.1,
                                    1,
                                  ]),
                              borderGradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  ColorService.gradientTopBorder,
                                  ColorService.gradientBottomBorder
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Text('Feels like',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center),
                                            const SizedBox(height: 4),
                                            Text('${_controller.currentWeather[3]} ℃',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center)
                                          ],
                                        )),
                                    Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Text('Pressure',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center),
                                            const SizedBox(height: 4),
                                            Text('${_controller.currentWeather[4]} inch',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center)
                                          ],
                                        )),
                                    Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Text('Cloud',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center),
                                            const SizedBox(height: 4),
                                            Text('${_controller.currentWeather[5]} %',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center)
                                          ],
                                        )),
                                    Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Text('Humidity',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center),
                                            const SizedBox(height: 4),
                                            Text('${_controller.currentWeather[6]} %',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center)
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            GlassmorphicContainer(
                                width: MediaQuery.of(context).size.width,
                                height: 220,
                                borderRadius: 30,
                                blur: 20,
                                alignment: Alignment.bottomCenter,
                                border: 2,
                                linearGradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      ColorService.gradientTopBody,
                                      ColorService.gradientBottomBody
                                    ],
                                    stops: const [
                                      0.1,
                                      1,
                                    ]),
                                borderGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    ColorService.gradientTopBorder,
                                    ColorService.gradientBottomBorder
                                  ],
                                ),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(10.0, 0.0, 8.0, 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              const Text('Wind',
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold)),
                                              const SizedBox(height: 4),
                                              Text(
                                                  '${_controller.currentWeather[7]} km/h',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text('Wind direction',
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold)),
                                              const SizedBox(height: 4),
                                              Text(
                                                  '${_controller.currentWeather[8]}° (${_controller.currentWeather[9]})',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text('Wind gust',
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold)),
                                              const SizedBox(height: 4),
                                              Text(
                                                  '${_controller.currentWeather[10]} km/h',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  'assets/images/image.png',
                                                ),
                                              )),
                                          child: Center(
                                            child: RotationTransition(
                                              turns: AlwaysStoppedAnimation(
                                                  _controller.currentWeather[8] /
                                                      360),
                                              child: Image.asset(
                                                  'assets/images/img_3.png',
                                                  height: 124,
                                                  color: ColorService.lightBlue1),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            const SizedBox(height: 20),
                            GlassmorphicContainer(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                borderRadius: 30,
                                blur: 20,
                                border: 2,
                                linearGradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      ColorService.gradientTopBody,
                                      ColorService.gradientBottomBody
                                    ],
                                    stops: const [
                                      0.1,
                                      1,
                                    ]),
                                borderGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    ColorService.gradientTopBorder,
                                    ColorService.gradientBottomBorder
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text('Sunrise',
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 10.0),
                                          Text(_controller.currentWeather[11],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      Expanded(
                                        child: Image.asset(
                                            'assets/images/sun_circle_line.png'),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text('Sunset',
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 10.0),
                                          Text(_controller.currentWeather[12],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                            const SizedBox(height: 20),
                            // WidgetSlider(
                            //     fixedSize: 220,
                            //     physics: const BouncingScrollPhysics(),
                            //     controller: _controller.sliderController,
                            //     itemCount: 24,
                            //     itemBuilder: (context, index, activeIndex) {
                            //       return CupertinoButton(
                            //           padding: EdgeInsets.zero,
                            //           onPressed: () async {
                            //             print('To page: $index');
                            //             await _controller.sliderController.moveTo
                            //                 ?.call(index);
                            //           },
                            //           child: HourlyData(
                            //               data: _controller
                            //                   .hourlyWeatherData.first[index]));
                            //     }),
                          ]
                      ),
                    )
                  ],
                ),
                  ),
        );
      },
    );
  }
}
