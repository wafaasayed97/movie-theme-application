import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_theming_app/core/extensions/ext.dart';
import 'package:movie_theming_app/core/theme/styles.dart';
import 'package:movie_theming_app/features/movies/data/models/movies_model.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Result movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
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
          style: font20w600.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: double.infinity,
                height: 450.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: movie.posterPath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.hide_image_outlined,
                              size: 60.h,
                              color: Theme.of(context).dividerColor,
                            );
                          },
                        ),
                      )
                    : Icon(
                        Icons.hide_image_outlined,
                        size: 60.h,
                        color: Theme.of(context).dividerColor,
                      ),
              ),
            ),
            24.hSpace,
            Text(
              movie.title ?? 'Unknown Title',
              style: font28w600.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            16.hSpace,
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 24.h),
                8.wSpace,
                Text(
                  '${movie.voteAverage?.toStringAsFixed(1) ?? '0.0'} / 10',
                  style: font18w600.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                16.wSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    movie.releaseDate ?? 'Unknown',
                    style: font14w500.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ),
              ],
            ),
            24.hSpace,
            Text(
              'Description',
              style: font20w600.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            12.hSpace,
            Text(
              movie.overview ??
                  'No description available for this movie.',
              style: font16w400.copyWith(
                color: Theme.of(context).hintColor,
                height: 1.5,
              ),
            ),
            24.hSpace,
            Text(
              'Additional Info',
              style: font20w600.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            12.hSpace,
            _buildInfoRow(
              context,
              'Original Title',
              movie.originalTitle ?? 'N/A',
            ),
            8.hSpace,
            _buildInfoRow(
              context,
              'Language',
              movie.originalLanguage?.toUpperCase() ?? 'N/A',
            ),
            8.hSpace,
            _buildInfoRow(
              context,
              'Popularity',
              movie.popularity?.toStringAsFixed(1) ?? 'N/A',
            ),
            8.hSpace,
            _buildInfoRow(
              context,
              'Vote Count',
              movie.voteCount?.toString() ?? 'N/A',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.w,
          child: Text(
            '$label:',
            style: font14w600.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: font14w400.copyWith(
              color: Theme.of(context).hintColor,
            ),
          ),
        ),
      ],
    );
  }
}