import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_theming_app/core/extensions/ext.dart';
import 'package:movie_theming_app/core/theme/styles.dart';
import 'package:movie_theming_app/features/movies/data/models/movies_model.dart';

class MovieCard extends StatelessWidget {
  final Result movie;
  final VoidCallback onTap;

  const MovieCard({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Theme.of(context).dividerColor, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 100.w,
              height: 140.h,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: movie.posterPath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.hide_image_outlined,
                            size: 40.h,
                            color: Theme.of(context).dividerColor,
                          );
                        },
                      ),
                    )
                  : Icon(
                      Icons.hide_image_outlined,
                      size: 40.h,
                      color: Theme.of(context).dividerColor,
                    ),
            ),
            16.wSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title ?? 'Unknown Title',
                    style: font16w600,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  12.hSpace,
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20.h),
                      6.wSpace,
                      Text(
                        '${movie.voteAverage?.toStringAsFixed(1) ?? '0.0'}/10',
                        style: font16w400,
                      ),
                    ],
                  ),
                  12.hSpace,
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
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
                      movie.releaseDate ?? 'Unknown',
                      style: font14w400.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, size: 28.h),
          ],
        ),
      ),
    );
  }
}