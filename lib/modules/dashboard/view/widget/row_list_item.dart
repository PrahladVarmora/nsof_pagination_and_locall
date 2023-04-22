import 'package:nstack_softech_practical/modules/dashboard/model/model_dashboard_list_item.dart';

import '../../../core/utils/common_import.dart';

/// The RowDashboardListItem class is a stateless widget in Dart.
class RowDashboardListItem extends StatelessWidget {
  final ModelDashboardListItem modelDashboardListItem;

  const RowDashboardListItem({Key? key, required this.modelDashboardListItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// This function is likely to return a widget that displays an avatar image.
    Widget avatarImage() {
      return Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(Dimens.margin5)),
        height: Dimens.margin70,
        width: Dimens.margin50,
        child: ImageViewerNetwork(
            url: (modelDashboardListItem.owner?.avatarUrl) ?? randomImage(),
            mHeight: Dimens.margin70,
            mWidth: Dimens.margin50),
      );
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(Dimens.margin16),
          child: Row(
            children: [
              avatarImage(),
              const SizedBox(width: Dimens.margin16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(modelDashboardListItem.name.toString(),
                        style: AppFont.semiBoldColorBlack20),
                    const SizedBox(height: Dimens.margin6),
                    Text(
                      modelDashboardListItem.description.toString(),
                      style: AppFont.semiBoldColor9A9A9A16,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Dimens.margin6),
                    Row(
                      children: [
                        if (modelDashboardListItem.language != null) ...[
                          Row(
                            children: [
                              const Icon(Icons.code),
                              const SizedBox(width: Dimens.margin3),
                              Text(
                                modelDashboardListItem.language.toString(),
                                style: AppFont.semiBoldColor9A9A9A16,
                              ),
                            ],
                          ),
                          const SizedBox(width: Dimens.margin10),
                        ],
                        if (modelDashboardListItem.hasIssues == true) ...[
                          Row(
                            children: [
                              const Icon(Icons.bug_report),
                              const SizedBox(width: Dimens.margin3),
                              Text(
                                modelDashboardListItem.openIssuesCount
                                    .toString(),
                                style: AppFont.semiBoldColor9A9A9A16,
                              ),
                            ],
                          ),
                          const SizedBox(width: Dimens.margin10),
                        ],
                        if (modelDashboardListItem.watchersCount != null) ...[
                          Row(
                            children: [
                              const Icon(Icons.face),
                              const SizedBox(width: Dimens.margin3),
                              Text(
                                modelDashboardListItem.watchersCount.toString(),
                                style: AppFont.semiBoldColor9A9A9A16,
                              ),
                            ],
                          ),
                        ],
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(color: AppColors.colorPrimary),
      ],
    );
  }
}
