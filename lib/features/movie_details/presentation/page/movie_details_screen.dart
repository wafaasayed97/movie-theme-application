import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_theming_app/core/extensions/ext.dart';
import 'package:movie_theming_app/core/helpers/screen_padding.dart';
import 'package:movie_theming_app/core/theme/styles.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          'Movie Details',
          style: font20w500.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: screenPadding(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 400.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(
                    Icons.hide_image_outlined,
                    size: 60.h,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ),
              24.hSpace,
              Text(movie.title, style: font28w600),
              16.hSpace,
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 24.h),
                  8.wSpace,
                  Text('${movie.rating} / 10', style: font18w600),
                  16.wSpace,
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      movie.genre,
                      style: font14w500.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                ],
              ),
              24.hSpace,
              Text('Description', style: font20w600),
              12.hSpace,
              Text(
                movie.description ??
                    'A computer programmer discovers that reality as he knows it is a simulation created by machines.',
                style: font16w400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieModel {
  final String title;
  final double rating;
  final String genre;
  final String? description;

  MovieModel({
    required this.title,
    required this.rating,
    required this.genre,
    this.description,
  });
}
